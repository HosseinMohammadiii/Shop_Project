import 'package:apple_shop/util/auth_manager.dart';
import 'package:dio/dio.dart';

class DioProvider {
  Dio createDio() {
    Dio dio = Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AuthManager.readAuth()}'
    }));
    return dio;
  }
}
