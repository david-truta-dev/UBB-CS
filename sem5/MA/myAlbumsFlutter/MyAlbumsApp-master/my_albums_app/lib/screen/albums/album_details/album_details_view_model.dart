import '../../../model/photo.dart';
import '../../../repo/photo_repo.dart';

class AlbumDetailsViewModel {
  PhotoRepo photoRepo;

  AlbumDetailsViewModel(this.photoRepo);

  Future<List<Photo>> fetchPhotosFromAlbum(int albumId) async {
    try {
      return (await photoRepo.getPhotosFromAlbum(albumId)).toList();
    } catch (err) {
      rethrow;
    }
  }
}
