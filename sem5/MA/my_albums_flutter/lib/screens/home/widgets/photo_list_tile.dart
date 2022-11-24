import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: AppColors.primaryColor.withOpacity(0.25),
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: SizedBox(
            height: 50,
            width: 50,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.network(photo.url),
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
            if (photo.albumTitle?.isNotEmpty != null)
              Text(
                "  Album: ${photo.albumTitle}",
                style: const TextStyle(color: Colors.grey),
              ),
            Text(
              "  Taken: ${DateFormat('yyyy-MM-dd').format(photo.dateTaken!)}",
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
        onTap: () => showDialog(
            context: context,
            builder: (context) => Center(
                  child: Stack(children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(child: Image.network(photo.url)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Material(
                          color: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
                )),
      ),
    );
  }
}
