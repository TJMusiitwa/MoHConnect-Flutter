import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

BaseOptions options = new BaseOptions(
  baseUrl: "https://www.xx.com/api",
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio dio = new Dio(options);

class DioService {
  Response response;
  Future<Dio> getService(String pathUrl, dynamic queryParameters) async {
    response = await dio.get(pathUrl,
        queryParameters: queryParameters,
        options: buildCacheOptions(Duration(days: 7)));
    return response.data;
  }

  Future<Dio> postService(String pathUrl, dynamic postData) async {
    response = await dio.post(pathUrl, data: postData);
    return response.data;
  }
}
