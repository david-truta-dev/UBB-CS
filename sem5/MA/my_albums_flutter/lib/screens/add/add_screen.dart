import 'package:flutter/material.dart';

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
  late TextFieldDescriptor _authorDescriptor;
  late TextFieldDescriptor _pagesDescriptor;
  late TextFieldDescriptor _ratingDescriptor;

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
    _authorDescriptor = TextFieldDescriptor(
        controller: TextEditingController(),
        decoration: _getDecoration("Author"));
    _pagesDescriptor = TextFieldDescriptor(
        controller: TextEditingController(),
        decoration: _getDecoration("Nr. of pages"));
    _ratingDescriptor = TextFieldDescriptor(
      controller: TextEditingController(),
      decoration: _getDecoration("Rating"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add book"),
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
                decoration: _authorDescriptor.decoration,
                controller: _authorDescriptor.controller,
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                decoration: _pagesDescriptor.decoration,
                controller: _pagesDescriptor.controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                decoration: _ratingDescriptor.decoration,
                controller: _ratingDescriptor.controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_viewModel.addPhoto(Photo(
                      id: PhotoRepo.getNextId(),
                      title: _titleDescriptor.controller.text,
                      author: _authorDescriptor.controller.text,
                      nrOfPages: int.parse(_pagesDescriptor.controller.text),
                      rating: int.parse(_pagesDescriptor.controller.text))));
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: const Text("Add book !"),
              ),
              const Icon(
                Icons.book_outlined,
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
