import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_albums_app/api/client_api.dart';
import 'package:my_albums_app/repo/photo_repo.dart';
import 'package:my_albums_app/screen/albums/album_details/widgets/album_header_widget.dart';
import 'package:my_albums_app/screen/albums/album_details/widgets/album_interatcion_widget.dart';
import 'package:my_albums_app/screen/albums/album_details/widgets/photo_list_widget.dart';
import 'package:my_albums_app/screen/albums/albums_view_model.dart';
import '../../../model/photo.dart';
import '../../../theming/dimensions.dart';
import 'album_details_view_model.dart';

class AlbumDetailsScreen extends StatelessWidget {
  final AlbumDetailsViewModel viewModel =
      AlbumDetailsViewModel(PhotoRepo(ClientApi(Dio())));
  final AlbumViewModel album;

  AlbumDetailsScreen({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: viewModel.fetchPhotosFromAlbum(album.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return const Center(
                  child: Text(
                '!!!Temporary ERROR!!!\n we also need to store photos locally',
                textAlign: TextAlign.center,
              ));
            } else {
              //final photos = snapshot.data as List<PhotoViewModel>; /// THIS IS FOR FUTURE VERSION
              final photos = snapshot.data as List<Photo>;
              return SingleChildScrollView(
                child: Center(
                    child: Padding(
                  padding: albumDetailsPadding,
                  child: Column(
                    children: [
                      AlbumHeaderWidget(
                        id: album.id,
                        title: album.title,
                      ),
                      const Divider(
                        thickness: dividerThickness,
                      ),
                      IntrinsicHeight(
                        child: Padding(
                          padding: albumInteractionPadding,
                          child: AlbumInteractionWidget(
                            nrOfPhotos: photos.length,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: dividerThickness,
                      ),
                      normalVerticalDistance,
                      PhotoListWidget(
                        photos: photos,
                      )
                    ],
                  ),
                )),
              );
            }
          }
        });
  }
}
