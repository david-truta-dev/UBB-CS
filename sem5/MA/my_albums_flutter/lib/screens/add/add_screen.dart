import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/photo.dart';
import '../../repo/photo_repo.dart';
import 'add_view_model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final AddViewModel _viewModel = AddViewModel(PhotoRepo());
  late TextFieldDescriptor _titleDescriptor;
  late TextFieldDescriptor _urlDescriptor;
  late TextFieldDescriptor _dateDescriptor;
  late TextFieldDescriptor _albumDescriptor;
  DateTime selectedDate = DateTime.now();

  InputDecoration _getDecoration(String title) => InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(color: Colors.grey),
      );

  @override
  void initState() {
    super.initState();
    _titleDescriptor = TextFieldDescriptor(
        controller: TextEditingController(),
        decoration: _getDecoration("Title"));
    _urlDescriptor = TextFieldDescriptor(
        controller: TextEditingController(), decoration: _getDecoration("URL"));
    _dateDescriptor = TextFieldDescriptor(
        controller: TextEditingController()
          ..text = DateFormat('yyyy-MM-dd').format(selectedDate),
        decoration: _getDecoration("Date Taken"));
    _albumDescriptor = TextFieldDescriptor(
      controller: TextEditingController(),
      decoration: _getDecoration("Album name"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add photo"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                decoration: _titleDescriptor.decoration,
                controller: _titleDescriptor.controller,
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                decoration: _urlDescriptor.decoration,
                controller: _urlDescriptor.controller,
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                readOnly: true,
                decoration: _dateDescriptor.decoration,
                controller: _dateDescriptor.controller,
                onTap: () => showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.utc(1800, 1, 1),
                  lastDate: DateTime.now(),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      selectedDate = value;
                      _dateDescriptor.controller.text =
                          DateFormat('yyyy-MM-dd').format(value);
                    });
                  }
                }),
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                decoration: _albumDescriptor.decoration,
                controller: _albumDescriptor.controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  _viewModel.addPhoto(
                    Photo(
                        id: PhotoRepo.getNextId(),
                        title: _titleDescriptor.controller.text,
                        url: _urlDescriptor.controller.text,
                        albumTitle: _albumDescriptor.controller.text.isNotEmpty
                            ? _albumDescriptor.controller.text
                            : null,
                        dateTaken: selectedDate),
                  );
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: const Text("Add photo !"),
              ),
              const Icon(
                Icons.photo,
                size: 200,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldDescriptor {
  final TextEditingController controller;
  final InputDecoration decoration;

  TextFieldDescriptor({
    required this.controller,
    required this.decoration,
  });
}
