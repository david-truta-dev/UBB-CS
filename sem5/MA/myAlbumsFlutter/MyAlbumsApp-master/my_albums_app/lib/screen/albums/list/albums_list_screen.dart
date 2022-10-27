import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_albums_app/BLoC/photo_query_bloc.dart';
import 'package:my_albums_app/screen/albums/album_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/widgets/list_tile_widget.dart';

import '../../../BLoC/bloc_provider.dart';
import '../../../theming/dimensions.dart';
import '../../../widgets/app_bar_widget.dart';
import '../details/album_detail_screen.dart';

class AlbumsListScreen extends StatefulWidget {
  final AlbumsViewModel viewModel;
  final List<AlbumViewModel> albums;

  const AlbumsListScreen(
      {Key? key, required this.albums, required this.viewModel})
      : super(key: key);

  @override
  State<AlbumsListScreen> createState() => _AlbumsListScreenState();
}

class _AlbumsListScreenState extends State<AlbumsListScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.viewModel.getSelectedAlbum != null) {
      final bloc = PhotoQueryBloc();
      bloc.submitQuery(widget.viewModel.getSelectedAlbum!.id);
      return Scaffold(
        appBar: AppBarWidget(
          title: Text(AppLocalizations.of(context)!.details,
              style: Theme.of(context).textTheme.headlineSmall),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
            onPressed: () {
              setState(() {
                widget.viewModel.setSelectedAlbum(null);
              });
            },
          ),
        ),
        body: BlocProvider<PhotoQueryBloc>(
          bloc: bloc,
          child: AlbumDetailScreen(album: widget.viewModel.getSelectedAlbum!),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBarWidget(
          title: Text(AppLocalizations.of(context)!.myAlbums,
              style: Theme.of(context).textTheme.headlineSmall),
          centerTitle: false,
        ),
        body: Center(
          child: ListView.separated(
            itemCount: widget.albums.length,
            padding: albumListPadding,
            separatorBuilder: (context, i) {
              return albumListTileDistance;
            },
            itemBuilder: (context, i) {
              return ListTileWidget(
                leadingIconData: Icons.photo_album_rounded,
                onTap: () {
                  setState(() {
                    if (widget.viewModel.isEven(widget.albums[i].id)) {
                      widget.viewModel.setSelectedAlbum(widget.albums[i]);
                    } else {
                      Fluttertoast.showToast(msg: "Id is uneven!");
                    }
                  });
                },
                title: Text(
                  widget.albums[i].title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                    '${AppLocalizations.of(context)!.albumWithId}: ${widget.albums[i].id}'),
              );
            },
          ),
        ),
      );
    }
  }
}
