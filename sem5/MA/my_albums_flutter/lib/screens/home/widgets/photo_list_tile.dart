import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../models/photo.dart';
import '../../../theme/app_colors.dart';

class PhotoListTile extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Photo photo;

  const PhotoListTile(
      {Key? key,
      required this.photo,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        minVerticalPadding: 7,
        dense: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: SizedBox(
            height: 50,
            width: 50,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.network(
                  "https://www.w3schools.com/w3css/img_lights.jpg"),
            ),
          ),
        ),
        title: Text(
          photo.title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "  ${photo.author}",
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              "  Nr. of pages: ${photo.nrOfPages.toString()}",
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              "  Rating: ${photo.rating.toString()}/10",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
        ),
        tileColor: AppColors.primaryColor.withOpacity(0.25),
      ),
    );
  }
}
