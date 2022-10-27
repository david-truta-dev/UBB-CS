import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../model/album.dart';
import '../model/photo.dart';

part 'client_api.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ClientApi {
  factory ClientApi(Dio dio, {String baseUrl}) = _ClientApi;

  @GET("/albums")
  Future<List<Album>> getAlbums();

  @GET("/photos")
  Future<List<Photo>> getPhotos();

  @GET("/photos/?albumId={albumId}")
  Future<List<Photo>> getPhotosFromAlbum(@Path("albumId") int albumId);
}

