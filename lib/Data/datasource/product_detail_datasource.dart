import 'package:apple_shop/Data/model/gellery.dart';
import 'package:apple_shop/Data/model/product_variant.dart';
import 'package:apple_shop/Data/model/variant.dart';
import 'package:apple_shop/Data/model/variant_type.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exeption.dart';
import 'package:dio/dio.dart';

abstract class IDetailProductDatasource {
  Future<List<ProductImage>> getGallery(String productId);
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariants();
  Future<List<ProductVariant>> getProductVariants();
}

class ProductDetailRemoteDatasource extends IDetailProductDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImage>> getGallery(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};
      var respons = await _dio.post(
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
      Map<String, String> qParams = {'filter': 'product_id="0tc0e5ju89x5ogj"'};
      var respons = await _dio.post(
        'collections/variants_type/records',
        queryParameters: qParams,
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
  Future<List<Variant>> getVariants() async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="0tc0e5ju89x5ogj"'};
      var respons = await _dio.post(
        'collections/variants/records',
        queryParameters: qParams,
      );
      return respons.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknow error');
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariants() async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariants();

    List<ProductVariant> productVariantList = [];

    for (var variantType in variantTypeList) {
      var variant = variantList
          .where((element) => element.typeId == variantType.id)
          .toList();
      productVariantList.add(ProductVariant(variantType, variant));
    }
    return productVariantList;
  }
}
