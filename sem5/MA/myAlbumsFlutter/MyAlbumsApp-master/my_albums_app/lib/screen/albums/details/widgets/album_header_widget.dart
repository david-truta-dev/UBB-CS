import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/theming/dimensions.dart';

class AlbumHeaderWidget extends StatelessWidget {
  final int id;
  final String title;

  const AlbumHeaderWidget({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        normalVerticalDistance,
        CircleAvatar(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
          minRadius: 40.0,
          child: Text(
            title[0],
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        normalVerticalDistance,
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        xSmallVerticalDistance,
        Text(
          '${AppLocalizations.of(context)!.albumWithId}: $id',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        normalVerticalDistance,
      ],
    );
  }
}
