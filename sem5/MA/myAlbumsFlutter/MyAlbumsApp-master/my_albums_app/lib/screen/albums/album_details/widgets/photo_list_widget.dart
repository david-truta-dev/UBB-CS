import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/screen/albums/album_details/add_edit_photo/add_edit_photo_widget.dart';

import '../../../../model/photo.dart';
import '../../../../theming/dimensions.dart';
import 'photo_details_widget.dart';

class PhotoListWidget extends StatefulWidget {
  final List<Photo> photos;

  const PhotoListWidget({Key? key, required this.photos}) : super(key: key);

  @override
  State<PhotoListWidget> createState() => _PhotoListWidgetState();
}

class _PhotoListWidgetState extends State<PhotoListWidget> {
  List<Photo> photos = [];

  VoidCallback _onTapPhoto(int i) => () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PhotoDetailsWidget(photo: widget.photos[i]),
        ),
      );

  VoidCallback _onTapEditPhoto(int i) => () => showDialog(
      context: context,
      builder: (context) => AddEditPhotoWidget(
            title: "Edit Photo",
            photoId: photos[i].id,
            albumId: photos[i].albumId!,
          )).then((value) => setState(() {
        photos = value;
      }));

  @override
  void initState() {
    super.initState();
    photos = widget.photos;
  }

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
          itemCount: photos.length,
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
                  photos[i].url!,
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
                photos[i].title!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                '${AppLocalizations.of(context)!.photoWithId}: ${photos[i].id}',
              ),
              onTap: _onTapPhoto(i),
              trailing: IconButton(
                onPressed: _onTapEditPhoto(i),
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
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
