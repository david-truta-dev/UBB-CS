import 'dart:async';

import 'package:dio/dio.dart';
import 'package:my_albums_app/BLoC/bloc.dart';
import 'package:my_albums_app/api/client_api.dart';

import '../model/photo.dart';

class PhotoQueryBloc implements Bloc {
  final _controller = StreamController<List<Photo>>();
  final _client = ClientApi(Dio());

  Stream<List<Photo>> get photoStream => _controller.stream;

  void submitQuery(int query) async {
    // 1
    final results = await _client.getPhotosFromAlbum(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}