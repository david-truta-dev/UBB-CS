import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_albums_app/api/client_api.dart';
import 'package:my_albums_app/repo/album_repo.dart';
import 'package:my_albums_app/screen/albums/album_details/add_edit_photo/add_edit_photo_widget.dart';
import 'package:my_albums_app/screen/albums/albums_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../theming/dimensions.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/list_tile_widget.dart';
import 'album_details/album_details_screen.dart';

class AlbumsScreen extends StatelessWidget {
  final AlbumsViewModel viewModel =
      AlbumsViewModel(AlbumRepo(ClientApi(Dio())));

  AlbumsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viewModel.getAlbums(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          List<AlbumViewModel> albums;
          if (snapshot.error != null) {
            return FutureBuilder(
              future: viewModel.getLocalAlbums(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.waiting) {
                  if (snapshot.error != null) {
                    albums = snapshot.data as List<AlbumViewModel>;
                    Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!.localAlbumsWereLoaded,
                    );
                    return _AlbumsListScreen(
                      albums: albums,
                      viewModel: viewModel,
                    );
                  } else {
                    Fluttertoast.showToast(msg: "There are no local albums");
                    return Container();
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            albums = snapshot.data as List<AlbumViewModel>;
            return _AlbumsListScreen(
              albums: albums,
              viewModel: viewModel,
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _AlbumsListScreen extends StatefulWidget {
  final AlbumsViewModel viewModel;
  final List<AlbumViewModel> albums;

  const _AlbumsListScreen(
      {Key? key, required this.albums, required this.viewModel})
      : super(key: key);

  @override
  State<_AlbumsListScreen> createState() => _AlbumsListScreenState();
}

class _AlbumsListScreenState extends State<_AlbumsListScreen> {
  VoidCallback _onAlbumTap(int i) => () => setState(() {
        widget.viewModel.setSelectedAlbum(widget.albums[i]);
      });

  VoidCallback get _onBackPressed => () => setState(() {
        widget.viewModel.setSelectedAlbum(null);
      });

  VoidCallback _onAddPressed(int i) => () => showDialog(
      context: context,
      builder: (context) => AddEditPhotoWidget(
            title: "Add Photo",
            albumId: widget.albums[i].id,
          )).then((value) => setState((){}));

  @override
  Widget build(BuildContext context) {
    return (widget.viewModel.getSelectedAlbum != null)
        ? _AlbumDetailsWidget(
            onBackPressed: _onBackPressed,
            onAddPressed: _onAddPressed,
            albumViewModel: widget.viewModel.getSelectedAlbum!,
          )
        : _AlbumsListWidget(
            onAlbumTap: _onAlbumTap,
            albums: widget.albums,
          );
  }
}

class _AlbumDetailsWidget extends StatelessWidget {
  final VoidCallback onBackPressed;
  final Function onAddPressed;
  final AlbumViewModel albumViewModel;

  const _AlbumDetailsWidget(
      {Key? key,
      required this.onBackPressed,
      required this.albumViewModel,
      required this.onAddPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Text(AppLocalizations.of(context)!.details,
            style: Theme.of(context).textTheme.headlineSmall),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: onBackPressed,
        ),
        actions: [
          IconButton(
              onPressed: onAddPressed(albumViewModel.id),
              icon: const Icon(Icons.add))
        ],
      ),
      body: AlbumDetailsScreen(album: albumViewModel),
    );
  }
}

class _AlbumsListWidget extends StatelessWidget {
  final Function onAlbumTap;
  final List<AlbumViewModel> albums;

  const _AlbumsListWidget(
      {Key? key, required this.onAlbumTap, required this.albums})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Text(AppLocalizations.of(context)!.myAlbums,
            style: Theme.of(context).textTheme.headlineSmall),
        centerTitle: false,
      ),
      body: Center(
        child: ListView.separated(
          itemCount: albums.length,
          padding: albumListPadding,
          separatorBuilder: (context, i) {
            return albumListTileDistance;
          },
          itemBuilder: (context, i) {
            return ListTileWidget(
              leadingIconData: Icons.photo_album_rounded,
              onTap: onAlbumTap(i),
              title: Text(
                albums[i].title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                  '${AppLocalizations.of(context)!.albumWithId}: ${albums[i].id}'),
            );
          },
        ),
      ),
    );
  }
}
