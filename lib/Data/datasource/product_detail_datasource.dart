import 'package:apple_shop/Data/model/category.dart';
import 'package:apple_shop/Data/model/gellery.dart';
import 'package:apple_shop/Data/model/product.dart';
import 'package:apple_shop/Data/model/product_variant.dart';
import 'package:apple_shop/Data/model/variant.dart';
import 'package:apple_shop/Data/model/variant_type.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exeption.dart';
import 'package:dio/dio.dart';

abstract class IDetailProductDatasource {
  Future<List<ProductImage>> getGallery(String productId);
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariants(String productId);
  Future<List<ProductVariant>> getProductVariants(String productId);
  Future<Categories> getProductCategory(String categoriesId);
  Future<Products> getProducts(String productsId);
  Future<List<Products>> getCategoryProducts(String categoriesId);
}

class ProductDetailRemoteDatasource extends IDetailProductDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImage>> getGallery(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};
      var respons = await _dio.get(
        'collections/gallery/records',
        queryParameters: qParams,
      );
      return respons.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknow error');
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var respons = await _dio.get(
        'collections/variants_type/records',
      );
      return respons.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknow error');
    }
  }

  @override
  Future<List<Variant>> getVariants(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};
      var respones = await _dio.get('collections/variants/records',
          queryParameters: qParams);

      return respones.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknow error');
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariants(String productId) async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariants(productId);

    List<ProductVariant> productVariantList = [];

    try {
      for (var variantType in variantTypeList) {
        var variant = variantList
            .where((element) => element.typeId == variantType.id)
            .toList();
        productVariantList.add(ProductVariant(variantType, variant));
      }

      return productVariantList;
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }

  @override
  Future<Categories> getProductCategory(String categoriesId) async {
    try {
      Map<String, String> qParams = {'filter': 'id="$categoriesId"'};
      var reponse = await _dio.get(
        'collections/category/records',
        queryParameters: qParams,
      );
      return Categories.fromMapJson(reponse.data['items'][0]);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }

  @override
  Future<Products> getProducts(String productsId) async {
    try {
      Map<String, String> qParams = {'filter': 'id="$productsId"'};
      var response = await _dio.get(
        'collections/products/records',
        queryParameters: qParams,
      );
      return Products.fromMapJson(response.data['items']);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknow error');
    }
  }

  @override
  Future<List<Products>> getCategoryProducts(String categoriesId) async {
    try {
      Map<String, String> qParams = {'filter': 'category="$categoriesId"'};
      Response<dynamic> response;
      if (categoriesId == '78q8w901e6iipuk') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get(
          'collections/products/records',
          queryParameters: qParams,
        );
      }
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
