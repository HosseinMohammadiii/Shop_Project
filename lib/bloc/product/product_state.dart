import 'package:apple_shop/Data/model/category.dart';
import 'package:apple_shop/Data/model/gellery.dart';
import 'package:apple_shop/Data/model/product.dart';
import 'package:apple_shop/Data/model/product_variant.dart';
import 'package:dartz/dartz.dart';

abstract class ProductState {}

class InitionProductState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVariant>> productVariant;
  Either<String, Products> products;
  Either<String, Categories> productCategory;

  ProductResponseState(this.productImages, this.productVariant,
      this.productCategory, this.products);
}
