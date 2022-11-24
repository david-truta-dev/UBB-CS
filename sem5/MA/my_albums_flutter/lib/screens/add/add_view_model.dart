import '../../models/photo.dart';
import '../../repo/photo_repo.dart';

class AddViewModel {
  final PhotoRepo _repo;

  AddViewModel(this._repo);

  bool addPhoto(Photo book) {
    return _repo.addPhoto(book);
  }
}
