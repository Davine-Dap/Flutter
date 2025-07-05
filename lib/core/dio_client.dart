import 'package:dio/dio.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio();
    dio.options.baseUrl = "http://127.0.0.1:5000/";
    dio.options.contentType = "application/json";
  }
}
