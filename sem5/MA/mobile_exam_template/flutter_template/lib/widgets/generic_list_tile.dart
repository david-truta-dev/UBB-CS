import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class GenericListTile extends StatelessWidget {
  final String title;
  final String? trailing;
  final List<String>? subtitles;

  const GenericListTile({
    Key? key,
    required this.title,
    this.trailing,
    this.subtitles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
          minVerticalPadding: 10,
          dense: false,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          tileColor: AppColors.primaryColor.withOpacity(0.25),
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          trailing: trailing != null
              ? Text(
                  trailing!,
                  style: const TextStyle(color: Colors.white70),
                )
              : _subtitlesWidget(CrossAxisAlignment.end),
          subtitle: trailing != null && subtitles != null
              ? _subtitlesWidget()
              : null),
    );
  }

  Widget _subtitlesWidget(
          [CrossAxisAlignment alignment = CrossAxisAlignment.start]) =>
      Column(
        crossAxisAlignment: alignment,
        children: subtitles
                ?.map((e) => Text(
                      e,
                      style: const TextStyle(color: Colors.white70),
                    ))
                .toList() ??
            [],
      );
}
