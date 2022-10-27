
import '../../../model/photo.dart';
import '../../../repo/photo_repo.dart';

class PhotosViewModel {
  PhotoRepo photoRepo;

  PhotosViewModel(this.photoRepo);

  Future<List<PhotoViewModel>> fetchPhotosFromAlbum(int albumId) async {
    try {
      return (await photoRepo.getPhotosFromAlbum(albumId))
          .map((a) => PhotoViewModel(a))
          .toList();
    } catch (err) {
      rethrow;
    }
  }
}

class PhotoViewModel {
  final Photo _photo;

  PhotoViewModel(this._photo);

  int get id {
    return _photo.id as int;
  }

  String get title {
    return _photo.title as String;
  }

  String get url {
    return _photo.url as String;
  }

  String get thumbnailUrl {
    return _photo.thumbnailUrl as String;
  }

  @override
  operator==(Object other){
    return other is PhotoViewModel && other._photo == _photo;
  }

  @override
  int get hashCode => id.hashCode;

}
