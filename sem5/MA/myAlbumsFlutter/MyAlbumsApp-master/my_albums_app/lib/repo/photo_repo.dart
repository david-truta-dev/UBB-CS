import '../api/client_api.dart';
import '../model/photo.dart';
import 'common.dart';

class PhotoRepo {
  static List<Photo> _photos = [];
  static final List<Photo> _added = [];
  final ClientApi api;

  PhotoRepo(this.api);

  Future<List<Photo>> getPhotos() async {
    return await (api.getPhotos()..then((value) => _photos = value..addAll(_added)))
        .catchError(handleError);
  }

  Future<List<Photo>> getPhotosFromAlbum(int albumId) async {
    return await (api.getPhotosFromAlbum(albumId)..then((value) => _photos = value..addAll(_added))).catchError(handleError);
  }

  Future<List<Photo>> addPhotosToAlbum(Photo photo) async {
    _added.add(photo);
    _photos.add(photo);
    return Future.value(_photos);
  }
}
