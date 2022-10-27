import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_albums_app/api/client_api.dart';
import 'package:my_albums_app/model/album.dart';
import 'package:my_albums_app/repo/album_repo.dart';
import 'package:my_albums_app/screen/albums/album_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group("album_view_model - ", () {
    AlbumsViewModel? albumsViewModel;
    AlbumViewModel? albumWithId13;

    //This will run before every test
    setUp(() {
      albumsViewModel = AlbumsViewModel(AlbumRepo(ClientApi(Dio())));
      SharedPreferences.setMockInitialValues({});
      albumWithId13 = AlbumViewModel(Album.fromJson({
        "userId": 2,
        "id": 13,
        "title": "ab rerum non rerum consequatur ut ea unde"
      }));
    });

    test(
        'isEven(int id) test case: should return true if id is even, false otherwise',
        () {
      var result = albumsViewModel!.isEven(3);
      expect(result, false);

      result = albumsViewModel!.isEven(1);
      expect(result, false);

      result = albumsViewModel!.isEven(6);
      expect(result, true);
    });

    test(
        '1.setSelected(AlbumViewModel? album) / 2.getSelected() : 1.should set selectedAlbum to given value 2.should fetch selectedAlbum',
        () {
      albumsViewModel!.setSelectedAlbum(albumWithId13);
      expect(albumsViewModel!.getSelectedAlbum, albumWithId13);

      albumsViewModel!.setSelectedAlbum(null);
      expect(albumsViewModel!.getSelectedAlbum, null);
    });

    test('fetchAlbums() test case: should fetch albums from client', () async {
      List<AlbumViewModel> actualAlbums = await albumsViewModel!.getAlbums();

      expect(actualAlbums.length, 100);

      expect(actualAlbums.firstWhere((element) => element.id == 13),
          albumWithId13);
    });

    test('fetchAlbums() test case: should throw an exception (no internet connection / unable to fetch)', () async {
      albumsViewModel = AlbumsViewModel(AlbumRepo(ClientApi(Dio(), baseUrl: "noInternet/unableToRetrieve")));

      expect(() => albumsViewModel!.getAlbums(), throwsA(isA<Exception>()));
    });

    test(
        "fetchLocalAlbums() test case: should fetch albums that are stored locally",
        () async {
      albumsViewModel = AlbumsViewModel(AlbumRepo(ClientApi(Dio())));

      // in order to have some local albums stored:
      await albumsViewModel!.getAlbums();

      List<AlbumViewModel> actualAlbums =
          await albumsViewModel!.getLocalAlbums();

      expect(actualAlbums.isNotEmpty, true);
      expect(actualAlbums.firstWhere((element) => element.id == 13), albumWithId13);
    });

    test(
        "fetchLocalAlbums() test case: should throw an exception (there are no local albums to fetch)",
        () async {
      albumsViewModel = AlbumsViewModel(AlbumRepo(ClientApi(Dio())));

      final prefs = await SharedPreferences.getInstance();
      prefs.clear();

      expect(() => albumsViewModel!.getLocalAlbums(), throwsA(isA<Exception>()));
    });
  });
}
