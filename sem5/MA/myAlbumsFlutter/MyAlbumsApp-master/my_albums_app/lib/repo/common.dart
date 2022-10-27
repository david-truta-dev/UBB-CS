import 'package:dio/dio.dart';

dynamic handleError(Object obj) {
  // non-200 error goes here.
  switch (obj.runtimeType) {
    case DioError:
      // Here's the sample to get the failed response error code and message
      final res = (obj as DioError).message;
      throw Exception(res);
    default:
      throw Exception(obj.toString());
  }
}
