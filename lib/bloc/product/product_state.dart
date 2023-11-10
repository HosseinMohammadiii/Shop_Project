import 'package:apple_shop/Data/model/category.dart';
import 'package:apple_shop/Data/model/gellery.dart';
import 'package:apple_shop/Data/model/product_variant.dart';
import 'package:dartz/dartz.dart';

abstract class ProductState {}

class InitionProductState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> productresponsImage;
  Either<String, List<ProductVariant>> productresponsVariant;
  Either<String, Categories> productresponsecategory;
  ProductResponseState(
    this.productresponsImage,
    this.productresponsVariant,
    this.productresponsecategory,
  );
}
