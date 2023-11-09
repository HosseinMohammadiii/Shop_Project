import 'package:apple_shop/Data/model/banner.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exeption.dart';
import 'package:dio/dio.dart';

abstract class IBannerDatasource {
  Future<List<Banners>> getBanner();
}

class BannerRemoteDatasource extends IBannerDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Banners>> getBanner() async {
    try {
      var response = await _dio.get('collections/banner/records');
      return response.data['items']
          .map<Banners>((jsonObject) => Banners.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown error');
    }
  }
}
