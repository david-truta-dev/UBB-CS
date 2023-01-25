import 'package:flutter/material.dart';
import 'package:flutter_template/screens/register/register_view_model.dart';

import '../../models/entity.dart';
import '../../repo/entity_repo.dart';
import '../../utils.dart';
import '../../widgets/entity_list_tile.dart';
import '../add/add_edit_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterViewModel _viewModel = RegisterViewModel(EntityRepo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Utils.checkInternetScreenWrapper(
        onRetry: () => setState(() {}),
        onUseLocal: () => setState(() {
          EntityRepo.useLocal = true;
        }),
        child: _screen,
      ),
    );
  }

  AppBar get _appBar => AppBar(
        title: const Text(
          "Register",
          style: TextStyle(fontSize: 30, color: Colors.black54),
        ),
        actions: [
          if (EntityRepo.useLocal)
            IconButton(
              onPressed: () => setState(() {
                EntityRepo.useLocal = false;
              }),
              icon: const Icon(Icons.refresh_rounded, color: Colors.black54),
            ),
          IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) => const AddEditScreen()))
                .then((_) {
              setState(() {});
            }),
            icon: const Icon(Icons.add_circle, color: Colors.black54),
          ),
        ],
      );

  Widget get _screen {
    return StreamBuilder<List<Plane>>(
        stream: _viewModel.getEntities(),
        builder: (context, snapshot2) {
          if (snapshot2.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Utils.displayError(context, snapshot2.error.toString());
            });
            return Container();
          }
          return snapshot2.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: snapshot2.data!
                      .map((e) => EntityListTile(entity: e))
                      .toList(),
                );
        });
  }
}
