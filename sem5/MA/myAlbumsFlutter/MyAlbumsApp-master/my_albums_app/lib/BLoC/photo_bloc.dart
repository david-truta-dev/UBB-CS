import 'dart:async';

import 'package:my_albums_app/BLoC/bloc.dart';

import '../model/photo.dart';

class PhotoBloc implements Bloc {
  // 1
  final _photoController = StreamController<Photo>();

  // 2
  Stream<Photo> get photoStream => _photoController.stream;

  // 3
  @override
  void dispose() {
    _photoController.close();
  }
}
