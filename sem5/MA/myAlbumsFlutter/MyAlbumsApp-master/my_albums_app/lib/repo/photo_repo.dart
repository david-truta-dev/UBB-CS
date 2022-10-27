import '../api/client_api.dart';
import '../model/photo.dart';
import 'common.dart';

class PhotoRepo {
  final ClientApi api;

  PhotoRepo(this.api);

  Future<List<Photo>> getPhotos() async {
    return await api.getPhotos().catchError(handleError);
  }

  Future<List<Photo>> getPhotosFromAlbum(int albumId) async {
    return await api.getPhotosFromAlbum(albumId).catchError(handleError);
  }
}
