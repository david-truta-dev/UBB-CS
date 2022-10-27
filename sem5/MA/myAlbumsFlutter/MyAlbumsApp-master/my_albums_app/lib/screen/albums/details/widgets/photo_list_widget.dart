import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../model/photo.dart';
import '../../../../theming/dimensions.dart';

class PhotoListWidget extends StatefulWidget {
  final List<Photo> photos;

  const PhotoListWidget({Key? key, required this.photos})
      : super(key: key);

  @override
  State<PhotoListWidget> createState() => _PhotoListWidgetState();
}

class _PhotoListWidgetState extends State<PhotoListWidget> {
  @override
  Widget build(BuildContext context) {
    final header = Row(
      children: [
        normalVerticalDistance,
        Text(
          AppLocalizations.of(context)!.photos,
          textAlign: TextAlign.start,
        ),
      ],
    );
    return ListView(
      key: const Key("outerListView"),
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      children: [
        header,
        smallVerticalDistance,
        ListView.separated(
          key: const Key("innerListView"),
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.photos.length,
          itemBuilder: (context, i) {
            return ListTile(
              minVerticalPadding: 0,
              horizontalTitleGap: photoListTileTitleGap,
              contentPadding: photoListTilePadding,
              leading: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Image.network(
                  widget.photos[i].thumbnailUrl!,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return ConstrainedBox(
                        constraints: circularProgressIndicatorBoxConstraint,
                        child:
                            const Center(child: CircularProgressIndicator()));
                  },
                ),
              ),
              title: Text(
                widget.photos[i].title!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                '${AppLocalizations.of(context)!.photoWithId}: ${widget.photos[i].id}',
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              thickness: dividerThickness,
            );
          },
        )
      ],
    );
  }
}
