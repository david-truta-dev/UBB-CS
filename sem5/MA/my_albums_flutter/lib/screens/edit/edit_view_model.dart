import '../../models/photo.dart';
import '../../repo/photo_repo.dart';

class EditViewModel {
  final PhotoRepo _repo;

  EditViewModel(this._repo);

  bool updatePhoto(Photo book) {
    return _repo.updatePhoto(book);
  }
}
