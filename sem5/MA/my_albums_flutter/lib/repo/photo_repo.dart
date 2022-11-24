import '../models/photo.dart';

class PhotoRepo {
  static int nextId = 4;
  static Map<int, Photo> photos = {
    0: Photo(
      id: 0,
      title: "Moara cu Noroc",
      url: "https://www.w3schools.com/w3css/img_lights.jpg",
    ),
    1: Photo(
      id: 1,
      title: "Mos Craciun",
      url: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
    ),
    2: Photo(
      id: 2,
      title: "Punguta cu doi bani",
      url: "https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ),
    3: Photo(
      id: 3,
      title: "Capra cu 3 yizi? plm",
      url: "https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ),
  };

  static int getNextId() => nextId++;

  bool addPhoto(Photo photo) {
    if (photos.containsKey(photo.id)) return false;
    photos[photo.id] = photo;
    return true;
  }

  bool deletePhoto(int id) {
    if (!photos.containsKey(id)) return false;
    photos.remove(id);
    return true;
  }

  bool updatePhoto(Photo photo) {
    photos.update(photo.id, (value) => photo);
    return true;
  }
}
