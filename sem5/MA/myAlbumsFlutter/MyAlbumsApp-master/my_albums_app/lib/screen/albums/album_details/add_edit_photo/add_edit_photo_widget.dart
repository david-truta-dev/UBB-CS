import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_albums_app/screen/albums/album_details/add_edit_photo/add_edit_photo_view_model.dart';

import '../../../../api/client_api.dart';
import '../../../../model/photo.dart';
import '../../../../repo/photo_repo.dart';
import '../../../../theming/colors.dart';
import '../../../../theming/dimensions.dart';
import '../../../../theming/text_styles.dart';

class AddEditPhotoWidget extends StatefulWidget {
  final int albumId;
  final String title;
  final int? photoId;

  const AddEditPhotoWidget(
      {Key? key, required this.title, required this.albumId, this.photoId})
      : super(key: key);

  @override
  State<AddEditPhotoWidget> createState() => _AddEditPhotoWidgetState();
}

class _AddEditPhotoWidgetState extends State<AddEditPhotoWidget> {
  final AddEditPhotoViewModel _viewModel =
  AddEditPhotoViewModel(PhotoRepo(ClientApi(Dio())));
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Center(
        child: Container(
          padding:
          const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: background,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Material(
            color: Colors.transparent,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                widget.title,
                style: headlineMediumTextStyle,
              ),
              smallVerticalDistance,
              const Divider(
                height: 1,
                thickness: 1,
              ),
              smallVerticalDistance,
              _MyTextField(
                title: "Title",
                controller: _titleController,
              ),
              smallVerticalDistance,
              _MyTextField(
                title: "Url",
                controller: _urlController,
              ),
              smallVerticalDistance,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "Cancel",
                        style: labelMediumTextStyle,
                      )),
                  TextButton(
                      onPressed: () {
                        _viewModel
                            .addPhotoToAlbum(Photo(
                          id: DateTime
                              .now()
                              .microsecondsSinceEpoch,
                          albumId: widget.albumId,
                          title: _titleController.text,
                          url: _urlController.text,
                          dateTaken: DateTime.now(),
                        ))
                            .then(
                              (photos) => Navigator.of(context).pop(photos),
                        );
                      },
                      child: const Text("Add", style: labelMediumTextStyle)),
                ],
              )
            ]),
          ),
        ),
      ),
      onWillPop: () => Future.value(false),
    );
  }
}

class _MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  const _MyTextField({Key? key, required this.title, required this.controller})
      : super(key: key);

  InputDecoration _getInputDecoration(BuildContext context, [String? title]) {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(
          color: Theme
              .of(context)
              .primaryColor,
          width: textFieldBorderThickness),
    );
    return InputDecoration(
        contentPadding: noPadding,
        floatingLabelStyle: Theme
            .of(context)
            .textTheme
            .labelMedium,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: title != null
            ? Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .labelMedium,
        )
            : null,
        enabledBorder: border,
        focusedBorder: border);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme
          .of(context)
          .textTheme
          .labelSmall,
      decoration: _getInputDecoration(context, title),
    );
  }
}
