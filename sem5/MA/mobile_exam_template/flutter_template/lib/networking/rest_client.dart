import 'package:flutter_template/models/entity.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' show Dio, Options, RequestOptions, ResponseType;

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:1876")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/all")
  Future<List<Plane>> getEntities();

  @GET("/types")
  Future<List<String>> getTypes();

  @GET("/my/{owner}")
  Future<List<Plane>> getEntitiesForOwner(@Path() String owner);

  @GET("/planes/{type}")
  Future<List<Plane>> getEntitiesForType(@Path() String type);

  @POST("/plane")
  Future<Plane> postEntity(@Body() Plane plane);

  @PUT("/planes/{id}")
  Future<Plane> putEntity(@Path() int id, @Body() Plane plane);

  @DELETE("/planes/{id}")
  Future<Plane> deleteEntity(@Path() int id);
}
