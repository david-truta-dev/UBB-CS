import 'package:flutter/material.dart';

import '../../../models/entity.dart';
import '../../../theme/app_colors.dart';

class EntityListTile extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Plane entity;

  const EntityListTile(
      {Key? key, required this.entity, this.onEdit, this.onDelete})
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
        title: Text(
          entity.name ?? "",
          style: const TextStyle(
              color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: onDelete != null && onEdit != null
              ? [
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
                ]
              : onDelete != null
                  ? [
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ]
                  : onEdit != null
                      ? [
                          IconButton(
                            onPressed: onEdit,
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ]
                      : [
                          const Icon(
                            Icons.info_outline,
                            color: Colors.white70,
                          )
                        ],
        ),
        onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(entity.name ?? ""),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entity.status ?? ""),
                      Text(entity.size.toString()),
                      Text(entity.owner ?? ""),
                      Text(entity.manufacturer ?? ""),
                      Text(entity.capacity.toString()),
                    ],
                  ),
                )),
      ),
    );
  }
}
