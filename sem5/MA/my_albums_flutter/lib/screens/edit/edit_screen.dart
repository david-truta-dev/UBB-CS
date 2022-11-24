import 'package:flutter/material.dart';

import '../../models/photo.dart';
import '../../repo/photo_repo.dart';
import '../add/add_screen.dart';
import 'edit_view_model.dart';

class EditScreen extends StatefulWidget {
  final Photo photo;

  const EditScreen({Key? key, required this.photo}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final EditViewModel _viewModel = EditViewModel(PhotoRepo());
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
        controller: TextEditingController()..text = widget.photo.title,
        decoration: _getDecoration("Title"));
    _authorDescriptor = TextFieldDescriptor(
        controller: TextEditingController()..text = widget.photo.author,
        decoration: _getDecoration("Author"));
    _pagesDescriptor = TextFieldDescriptor(
        controller: TextEditingController()
          ..text = widget.photo.nrOfPages.toString(),
        decoration: _getDecoration("Nr. of pages"));
    _ratingDescriptor = TextFieldDescriptor(
      controller: TextEditingController()..text = widget.photo.rating.toString(),
      decoration: _getDecoration("Rating"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit photo"),
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
                  _viewModel.updatePhoto(Photo(
                      id: widget.photo.id,
                      title: _titleDescriptor.controller.text,
                      author: _authorDescriptor.controller.text,
                      nrOfPages: int.parse(_pagesDescriptor.controller.text),
                      rating: int.parse(_ratingDescriptor.controller.text)));
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: const Text("Edit photo !"),
              ),
              const Icon(
                Icons.photo_outlined,
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
