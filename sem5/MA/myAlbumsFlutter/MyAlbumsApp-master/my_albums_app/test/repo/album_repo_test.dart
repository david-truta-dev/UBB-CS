import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_albums_app/api/client_api.dart';
import 'package:my_albums_app/model/album.dart';
import 'package:my_albums_app/repo/album_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group("album_repo - ", () {
    AlbumRepo? albumRepo;
    Album? albumWithId13;

    //This will run before every test
    setUp(() {
      albumRepo = AlbumRepo(ClientApi(Dio()));
      SharedPreferences.setMockInitialValues({});
      albumWithId13 = Album.fromJson({
        "userId": 2,
        "id": 13,
        "title": "ab rerum non rerum consequatur ut ea unde"
      });
    });

    test('getAlbums() test case: should fetch albums from client', () async {
      List<Album> actualAlbums = await albumRepo!.getAlbums();

      expect(actualAlbums.length, 100);

      expect(
          actualAlbums.firstWhere((element) => element.id == 13),
          albumWithId13);
    });

    test('getAlbums() test case: should save fetched albums locally', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('albums');

      await albumRepo!.getAlbums();

      final List<String>? albums = prefs.getStringList('albums');

      final actualAlbumWithId13 = albums!.map((a) {
        final args = a.split(",");
        return Album(
            id: int.parse(args[0]), userId: int.parse(args[1]), title: args[2]);
      }).toList().firstWhere((element) => element.id == 13);

      expect(actualAlbumWithId13, albumWithId13);
    });

    test("getAlbums() test case: should throw an exception (wasn't able to fetch albums)", () {
      albumRepo = AlbumRepo(
          ClientApi(Dio(), baseUrl: "https://jsonplaceholder.typicode.error/"));

      expect(() => albumRepo!.getAlbums(), throwsA(isA<Exception>()));
    });
  });
}
