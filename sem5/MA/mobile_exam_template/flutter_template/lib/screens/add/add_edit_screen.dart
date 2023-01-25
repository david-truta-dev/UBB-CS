import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/models/entity.dart';
import 'package:flutter_template/repo/entity_repo.dart';

import '../../../utils.dart';
import 'add_edit_view_model.dart';

class AddEditScreen extends StatefulWidget {
  final Plane? entityToUpdate;

  const AddEditScreen({Key? key, this.entityToUpdate}) : super(key: key);

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final AddEditViewModel _viewModel = AddEditViewModel(EntityRepo());
  late TextFieldDescriptor _nameDescriptor;
  late TextFieldDescriptor _statusDescriptor;
  late TextFieldDescriptor _sizeDescriptor;
  late TextFieldDescriptor _ownerDescriptor;
  late TextFieldDescriptor _manufacturerDescriptor;
  late TextFieldDescriptor _capacityDescriptor;
  late bool _isInEditMode;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _isInEditMode = widget.entityToUpdate != null;
    _nameDescriptor = TextFieldDescriptor(
      controller: TextEditingController()
        ..text = widget.entityToUpdate?.name ?? "",
      decoration: _getDecoration("Name"),
    );
    _statusDescriptor = TextFieldDescriptor(
      controller: TextEditingController()
        ..text = widget.entityToUpdate?.status ?? "",
      decoration: _getDecoration("Status"),
    );
    _sizeDescriptor = TextFieldDescriptor(
      controller: TextEditingController()
        ..text = widget.entityToUpdate?.size.toString() ?? "",
      decoration: _getDecoration("Size"),
      numericInput: true,
    );
    _ownerDescriptor = TextFieldDescriptor(
      controller: TextEditingController()
        ..text = widget.entityToUpdate?.owner ?? "",
      decoration: _getDecoration("Owner"),
    );
    _manufacturerDescriptor = TextFieldDescriptor(
      controller: TextEditingController()
        ..text = widget.entityToUpdate?.manufacturer ?? "",
      decoration: _getDecoration("Manufacturer"),
    );
    _capacityDescriptor = TextFieldDescriptor(
      controller: TextEditingController()
        ..text = widget.entityToUpdate?.capacity.toString() ?? "",
      decoration: _getDecoration("Capacity"),
      numericInput: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  Widget get _body => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _textFieldFromDescriptor(_nameDescriptor),
              _textFieldFromDescriptor(_statusDescriptor),
              _textFieldFromDescriptor(_sizeDescriptor),
              _textFieldFromDescriptor(_ownerDescriptor),
              _textFieldFromDescriptor(_manufacturerDescriptor),
              _textFieldFromDescriptor(_capacityDescriptor),
            ],
          ),
        ),
      );

  AppBar get _appBar => AppBar(
        foregroundColor: Colors.black54,
        title: Text(
          _isInEditMode ? "EDIT" : "ADD",
          style: const TextStyle(fontSize: 30, color: Colors.black54),
        ),
        actions: [
          IconButton(
            onPressed: _onDonePressed,
            icon: const Icon(
              Icons.check,
              color: Colors.black54,
            ),
          )
        ],
      );

  VoidCallback get _onDonePressed => () {
        listener(response) {
          if (response == "ok") {
            Navigator.of(context).pop();
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Utils.displayError(context, response.toString());
            });
          }
        }

        var plane = Plane(
            id: _isInEditMode ? widget.entityToUpdate!.id : null,
            name: _nameDescriptor.controller.text,
            status: _statusDescriptor.controller.text,
            size: _sizeDescriptor.controller.text.isNotEmpty
                ? int.parse(_sizeDescriptor.controller.text)
                : 0,
            owner: _ownerDescriptor.controller.text,
            manufacturer: _manufacturerDescriptor.controller.text,
            capacity: _capacityDescriptor.controller.text.isNotEmpty
                ? int.parse(_capacityDescriptor.controller.text)
                : 0);

        if (_isInEditMode) {
          _subscription = _viewModel.updateEntity(plane).listen(listener);
        } else {
          _subscription = _viewModel.addEntity(plane).listen(listener);
        }
      };

  Widget _textFieldFromDescriptor(TextFieldDescriptor descriptor) => TextField(
        decoration: descriptor.decoration,
        controller: descriptor.controller,
        keyboardType:
            descriptor.numericInput ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white),
      );

  InputDecoration _getDecoration(String title) => InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(color: Colors.grey),
      );

  @override
  void dispose() {
    _subscription?.cancel();
    _nameDescriptor.controller.dispose();
    _statusDescriptor.controller.dispose();
    _capacityDescriptor.controller.dispose();
    _ownerDescriptor.controller.dispose();
    _manufacturerDescriptor.controller.dispose();
    _sizeDescriptor.controller.dispose();
    super.dispose();
  }
}

class TextFieldDescriptor {
  final TextEditingController controller;
  final InputDecoration decoration;
  final bool numericInput;

  TextFieldDescriptor({
    required this.controller,
    required this.decoration,
    this.numericInput = false,
  });
}
