import 'package:apple_shop/Data/datasource/product_datasource.dart';
import 'package:apple_shop/Data/model/product.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exeption.dart';
import 'package:dartz/dartz.dart';

abstract class IProductsRepository {
  Future<Either<String, List<Products>>> getProducts();
  Future<Either<String, List<Products>>> getHotest();
  Future<Either<String, List<Products>>> getBestseller();
}

class ProductRepository extends IProductsRepository {
  final IProductsDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Products>>> getProducts() async {
    try {
      var response = await _datasource.getProducts();
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Products>>> getBestseller() async {
    try {
      var response = await _datasource.getBestseller();
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Products>>> getHotest() async {
    try {
      var response = await _datasource.getHotest();
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
