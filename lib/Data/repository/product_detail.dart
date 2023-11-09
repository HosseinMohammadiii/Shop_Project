import 'package:apple_shop/Data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/Data/model/gellery.dart';
import 'package:apple_shop/Data/model/product_variant.dart';
import 'package:apple_shop/Data/model/variant_type.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exeption.dart';
import 'package:dartz/dartz.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImage>>> getGallery(String productId);
  Future<Either<String, List<VariantType>>> getVariantTypes();
  Future<Either<String, List<ProductVariant>>> getProductVariants();
}

class ProductDetailRepository extends IProductDetailRepository {
  final IDetailProductDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<ProductImage>>> getGallery(
      String productId) async {
    try {
      var respose = await _datasource.getGallery(productId);
      return right(respose);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantTypes() async {
    try {
      var respose = await _datasource.getVariantTypes();
      return right(respose);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getProductVariants() async {
    try {
      var respose = await _datasource.getProductVariants();
      return right(respose);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
