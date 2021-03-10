import 'package:dio/dio.dart';
import 'package:weather/app/infrastructure/interfaces/http-client.interface.dart';

class DioHttpClient implements IHttpClient {
  var dio;

  DioHttpClient() {
    dio = new Dio();
  }

  @override
  Future get(String url) {
    return dio.get(url);
  }
}
