import 'package:weather/app/models/response.model.dart';

abstract class IHttpClient{
  Future get(String url);
}