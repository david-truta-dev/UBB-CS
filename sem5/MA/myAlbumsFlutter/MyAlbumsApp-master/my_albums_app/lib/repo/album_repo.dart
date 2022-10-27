import 'package:shared_preferences/shared_preferences.dart';

import '../api/client_api.dart';
import '../model/album.dart';
import 'common.dart';

class AlbumRepo {
  final ClientApi api;

  AlbumRepo(this.api);

  Future<List<Album>> getAlbums() async {
    final albums = await api.getAlbums().catchError(handleError);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('albums');
    await prefs.setStringList(
        'albums', [...albums.map((a) => "${a.id},${a.userId},${a.title}")]);

    return albums;
  }

  Future<List<Album>> getLocalAlbums() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final List<String>? albums = prefs.getStringList('albums');
      return albums!.map((a) {
        final args = a.split(",");
        return Album(
            id: int.parse(args[0]), userId: int.parse(args[1]), title: args[2]);
      }).toList();
    } catch (err) {
      throw Exception("There are no local albums");
    }
  }
}
