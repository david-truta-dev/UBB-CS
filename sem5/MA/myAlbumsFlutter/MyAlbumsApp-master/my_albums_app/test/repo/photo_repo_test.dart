import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_albums_app/api/client_api.dart';
import 'package:my_albums_app/model/photo.dart';
import 'package:my_albums_app/repo/photo_repo.dart';

void main() {
  group("photo_repo - ", () {
    PhotoRepo? photoRepo;
    Photo? photoWithId113;

    //This will run before every test
    setUp(() {
      photoRepo = PhotoRepo(ClientApi(Dio()));
      photoWithId113 = Photo.fromJson({
        "albumId": 3,
        "id": 113,
        "title": "hic nulla consectetur",
        "url": "https://via.placeholder.com/600/1dff02",
        "thumbnailUrl": "https://via.placeholder.com/150/1dff02"
      });
    });

    test('getPhotos() - should fetch photos from client', () async {
      List<Photo> actualPhotos = await photoRepo!.getPhotos();

      expect(actualPhotos.length, 5000);

      expect(actualPhotos.firstWhere((element) => element.id == 113),
          photoWithId113);
    });

    test(
        "getPhotos() - should throw an exception (wasn't able to fetch photos)",
            () {
          photoRepo = PhotoRepo(
              ClientApi(
                  Dio(), baseUrl: "https://jsonplaceholder.typicode.error/"));

          expect(() => photoRepo!.getPhotos(), throwsA(isA<Exception>()));
        });

    test(
        "getPhotosFromAlbum(int albumId) - should fetch photos with the given albumId from client",
            () async {
          photoRepo = PhotoRepo(
              ClientApi(Dio()));

          List<Photo> actualPhotos = await photoRepo!.getPhotosFromAlbum(3);

          expect(actualPhotos.length, 50);
          expect(
              actualPhotos.firstWhere((element) => element.id == 113), photoWithId113);
        });

    test(
        "getPhotosFromAlbum(int albumId) - should result to an empty list if there are no photos with given albumId",
            () async {
          photoRepo = PhotoRepo(
              ClientApi(Dio()));

          List<Photo> actualPhotos = await photoRepo!.getPhotosFromAlbum(110);

          expect(actualPhotos.length, 0);
        });

    test(
        "getPhotosFromAlbum(int id) - should throw an exception (wasn't able to fetch photos)",
            () async {
          photoRepo = PhotoRepo(
              ClientApi(
                  Dio(), baseUrl: "https://jsonplaceholder.typicode.error/"));

          expect(() => photoRepo!.getPhotosFromAlbum(3), throwsA(isA<Exception>()));
        });
  });
}
