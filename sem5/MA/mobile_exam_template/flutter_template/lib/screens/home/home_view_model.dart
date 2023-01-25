import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/entity.dart';

class HomeViewModel {
  final _channel = WebSocketChannel.connect(
    //TODO change the uri
    Uri.parse('ws://10.0.2.2:1876'),
  );

  Stream<Plane> listenForAddedPlanes() {
    return _channel.stream.delay(const Duration(seconds: 1)).flatMap((value) {
      Plane plane;
      try {
        value = json.decode(value) as Map<String, dynamic>;
        plane = Plane.fromJson(value);
      } catch (error) {
        return Stream.error(error);
      }
      return Stream.value(plane);
    });
  }

  dispose() {
    _channel.sink.close();
  }
}
