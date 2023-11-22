import 'package:apple_shop/Data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/Data/model/category.dart';
import 'package:apple_shop/Data/model/gellery.dart';
import 'package:apple_shop/Data/model/product.dart';
import 'package:apple_shop/Data/model/product_variant.dart';
import 'package:apple_shop/Data/model/variant_type.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exeption.dart';
import 'package:dartz/dartz.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImage>>> getGallery(String productId);
  Future<Either<String, List<VariantType>>> getVariantTypes();
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId);
  Future<Either<String, Categories>> getProductCategory(String categoriesId);
  Future<Either<String, Products>> getProducts(String productsId);
  Future<Either<String, List<Products>>> getCategoryProducts(
      String categoriesId);
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
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId) async {
    try {
      var respose = await _datasource.getProductVariants(productId);
      return right(respose);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Categories>> getProductCategory(
      String categoriesId) async {
    try {
      var respose = await _datasource.getProductCategory(categoriesId);
      return right(respose);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Products>> getProducts(String productsId) async {
    try {
      var respose = await _datasource.getProducts(productsId);
      return right(respose);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Products>>> getCategoryProducts(
      String categoriesId) async {
    try {
      var response = await _datasource.getCategoryProducts(categoriesId);
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
