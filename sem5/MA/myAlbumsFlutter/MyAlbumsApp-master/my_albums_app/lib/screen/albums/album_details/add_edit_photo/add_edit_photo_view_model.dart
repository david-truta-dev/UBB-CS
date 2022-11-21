import 'package:my_albums_app/repo/photo_repo.dart';

import '../../../../model/photo.dart';

class AddEditPhotoViewModel{
  final PhotoRepo _photoRepo;

  AddEditPhotoViewModel(this._photoRepo);

  Future<List<Photo>> addPhotoToAlbum(Photo photo){
    print(photo.title);
    print(photo.url);
    return _photoRepo.addPhotosToAlbum(photo);
  }

}