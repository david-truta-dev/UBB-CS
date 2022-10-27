import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_albums_app/api/client_api.dart';
import 'package:my_albums_app/model/photo.dart';
import 'package:my_albums_app/repo/photo_repo.dart';
import 'package:my_albums_app/screen/albums/details/photo_view_model.dart';

void main() {
  group("photo_view_model - ", () {
    PhotosViewModel? photosViewModel;
    PhotoViewModel? photoWithId113;

    //This will run before every test
    setUp(() {
      photosViewModel = PhotosViewModel(PhotoRepo(ClientApi(Dio())));
      photoWithId113 = PhotoViewModel(Photo.fromJson({
        "albumId": 3,
        "id": 113,
        "title": "hic nulla consectetur",
        "url": "https://via.placeholder.com/600/1dff02",
        "thumbnailUrl": "https://via.placeholder.com/150/1dff02"
      }));
    });

    test(
        'fetchPhotosFromAlbum(int albumId) test case: should fetch photos for albumId from client',
        () async {
      List<PhotoViewModel> actualPhotos =
          await photosViewModel!.fetchPhotosFromAlbum(3);

      expect(actualPhotos.length, 50);

      expect(actualPhotos.firstWhere((element) => element.id == 113),
          photoWithId113);
    });

    test(
        'fetchPhotosFromAlbums(int albumId) test case: should return an empty list if there are no photos for album',
        () async {
      photosViewModel = PhotosViewModel(PhotoRepo(ClientApi(Dio())));

      List<PhotoViewModel> actualPhotos =
          await photosViewModel!.fetchPhotosFromAlbum(110);

      expect(actualPhotos.isEmpty, true);
    });

    test(
        'fetchPhotosFromAlbums(int albumId) test case: should throw an exception (no internet connection / unable to fetch)',
        () async {
      photosViewModel = PhotosViewModel(
          PhotoRepo(ClientApi(Dio(), baseUrl: "noInternet/unableToRetrieve")));

      expect(() => photosViewModel!.fetchPhotosFromAlbum(3),
          throwsA(isA<Exception>()));
    });
  });
}
