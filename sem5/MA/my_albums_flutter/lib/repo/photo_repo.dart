import '../models/photo.dart';

class PhotoRepo {
  static int nextId = 4;
  static Map<int, Photo> photos = {
    0: Photo(
      id: 0,
      title: "Moara cu Noroc",
      author: "Ioan Slavici",
    ),
    1: Photo(
      id: 1,
      title: "Mos Craciun si prietenii sai",
      author: "Mircea Eliade",
    ),
    2: Photo(
      id: 2,
      title: "Punguta cu doi bani",
      author: "Creanga efectiv",
    ),
    3: Photo(
      id: 3,
      title: "Capra cu 3 yizi? plm",
      author: "Creanga efectiv",
    ),
    4: Photo(
      id: 4,
      title: "Capra cu 3 yizi? plm",
      author: "Creanga efectiv",
    ),
    5: Photo(
      id: 5,
      title: "Capra cu 3 yizi? plm",
      author: "Creanga efectiv",
    ),
    6: Photo(
      id: 6,
      title: "Capra cu 3 yizi? plm",
      author: "Creanga efectiv",
    ),
    7: Photo(
      id: 7,
      title: "Capra cu 3 yizi? plm",
      author: "Creanga efectiv",
    ),
    8: Photo(
      id: 8,
      title: "Capra cu 3 yizi? plm",
      author: "Creanga efectiv",
    ),
  };

  static int getNextId() => nextId++;

  bool addPhoto(Photo book) {
    if (photos.containsKey(book.id)) return false;
    photos[book.id] = book;
    return true;
  }

  bool deletePhoto(int id) {
    if (!photos.containsKey(id)) return false;
    photos.remove(id);
    return true;
  }

  bool updatePhoto(Photo book) {
    photos.update(book.id, (value) => book);
    return true;
  }
}
