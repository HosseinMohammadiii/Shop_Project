import 'package:apple_shop/Data/model/product.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exeption.dart';
import 'package:dio/dio.dart';

abstract class IProductsDatasource {
  Future<List<Products>> getProducts();
  Future<List<Products>> getHotest();
  Future<List<Products>> getBestseller();
}

class ProductsRemoteDatasource extends IProductsDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Products>> getProducts() async {
    try {
      var response = await _dio.get('collections/products/records');
      return response.data['items']
          .map<Products>((jsonObject) => Products.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknow error');
    }
  }

  @override
  Future<List<Products>> getBestseller() async {
    try {
      Map<String, String> qParams = {'filter': 'popularity="Best Seller"'};
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Products>((jsonObject) => Products.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknow error');
    }
  }

  @override
  Future<List<Products>> getHotest() async {
    try {
      Map<String, String> qParams = {'filter': 'popularity="Hotest"'};
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Products>((jsonObject) => Products.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknow error');
    }
  }
}
