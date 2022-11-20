import 'package:flutter/material.dart';

import '../../../../model/photo.dart';


class PhotoDetailsWidget extends StatelessWidget {
  final Photo photo;

  const PhotoDetailsWidget({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(photo.url!);
  }
}
