import '../../models/photo.dart';
import '../../repo/photo_repo.dart';

class HomeViewModel {
  final PhotoRepo _repo;

  HomeViewModel(this._repo);

  List<Photo> getPhotos() {
    return PhotoRepo.photos.values.toList();
  }

  bool deletePhotos(int id){
    return _repo.deletePhoto(id);
  }
}
