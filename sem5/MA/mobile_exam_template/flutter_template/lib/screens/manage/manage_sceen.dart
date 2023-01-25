import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/screens/manage/manage_view_model.dart';
import 'package:flutter_template/widgets/entity_list_tile.dart';

import '../../models/entity.dart';
import '../../repo/entity_repo.dart';
import '../../utils.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({Key? key}) : super(key: key);

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  final ManageViewModel _viewModel = ManageViewModel(EntityRepo());
  StreamSubscription? _subscription;
  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Utils.checkInternetScreenWrapper(
        onRetry: () => setState(() {}),
        child: _selectedType == null ? _typeList : _entitiesOfSelectedType,
      ),
    );
  }

  Widget get _entitiesOfSelectedType => StreamBuilder<List<Plane>>(
        stream: _viewModel.getEntitiesForType(_selectedType!),
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Utils.displayError(context, snapshot.error.toString());
            });
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data!
                  .map((e) => EntityListTile(
                        entity: e,
                        onDelete: _onDeletePressed(e),
                      ))
                  .toList(),
            );
          }
        },
      );

  Widget get _typeList => StreamBuilder<List<String>>(
        stream: _viewModel.getEntityTypes(),
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Utils.displayError(context, snapshot.error.toString());
            });
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: ListTile(
                    title: Text(
                      snapshot.data![index],
                      style: const TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white70),
                    onTap: () => setState(() {
                      _selectedType = snapshot.data![index];
                    }),
                  )),
              separatorBuilder: (_, index) =>
                  const Divider(color: Colors.white70),
            );
          }
        },
      );

  VoidCallback _onDeletePressed(Plane e) => () {
        listener(response) {
          if (response == "ok") {
            setState(() {});
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Utils.displayError(context, response.toString());
            });
          }
        }

        _subscription = _viewModel.deleteEntity(e.id!).listen(listener);
      };

  AppBar get _appBar => AppBar(
        title: Text(
          _selectedType == null ? "Manage" : _selectedType!,
          style: const TextStyle(fontSize: 30, color: Colors.black54),
        ),
        actions: [
          if (_selectedType != null)
            TextButton(
                onPressed: () => setState(() {
                      _selectedType = null;
                    }),
                child: const Text(
                  "Back   ",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ))
        ],
      );

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
