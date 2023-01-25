import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/repo/shared_pref_repo.dart';
import 'package:flutter_template/screens/owner/owner_view_model.dart';
import 'package:flutter_template/theme/app_colors.dart';

import '../../repo/entity_repo.dart';
import '../../utils.dart';
import '../../widgets/entity_list_tile.dart';

class OwnerScreen extends StatefulWidget {
  const OwnerScreen({Key? key}) : super(key: key);

  @override
  State<OwnerScreen> createState() => _OwnerScreenState();
}

class _OwnerScreenState extends State<OwnerScreen> {
  final OwnerViewModel _viewModel =
      OwnerViewModel(SharedPrefsRepo(), EntityRepo());
  final TextEditingController _textEditingController = TextEditingController();
  StreamSubscription? _subscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Utils.checkInternetScreenWrapper(
        onRetry: () => setState(() {}),
        child: _screen,
      ),
    );
  }

  Widget get _screen => SingleChildScrollView(
        child: StreamBuilder(
            stream: _viewModel.getOwnerName(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Center(
                            child: Icon(
                          Icons.account_circle,
                          size: 200,
                        )),
                        Text(
                          snapshot.data == null
                              ? "Owner name is not set!"
                              : snapshot.data!,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            labelStyle: const TextStyle(color: Colors.grey),
                            suffix: IconButton(
                              onPressed: _onSave,
                              icon: const Icon(
                                Icons.check,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          controller: _textEditingController,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        if (snapshot.data != null) ...[
                          Text(
                            "${snapshot.data}'s planes:",
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          _ownerPlanesWidget(snapshot.data!)
                        ]
                      ],
                    );
            }),
      );

  Widget _ownerPlanesWidget(String owner) =>
      StreamBuilder(
      stream: _viewModel.getPlanesOfOwner(owner),
      builder: (context2, snapshot2) {
        if (snapshot2.error != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Utils.displayError(context, snapshot2.error.toString());
          });
          return Container();
        }
        return snapshot2.connectionState == ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot2.data!
                    .map((e) => EntityListTile(entity: e))
                    .toList(),
              );
      });

  AppBar get _appBar => AppBar(
        title: const Text(
          "Owner",
          style: TextStyle(fontSize: 30, color: Colors.black54),
        ),
      );

  VoidCallback get _onSave => () {
        _subscription = _viewModel
            .setOwnerName(_textEditingController.text)
            .listen((event) {
          if (!event) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Utils.displayError(
                  context, "There was an error setting the name!");
            });
          } else {
            setState(() {
              _textEditingController.clear();
            });
          }
        });
      };

  @override
  void dispose() {
    _subscription?.cancel();
    _textEditingController.dispose();
    super.dispose();
  }
}
