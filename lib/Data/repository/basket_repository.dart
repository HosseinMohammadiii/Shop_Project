import 'package:apple_shop/Data/datasource/basket_datasource.dart';
import 'package:apple_shop/Data/model/card_item.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exeption.dart';
import 'package:dartz/dartz.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketItems();
}

class BasketRepository extends IBasketRepository {
  final IBasketDatasource _datasource = locator.get();
  @override
  Future<Either<String, String>> addProductToBasket(
      BasketItem basketItem) async {
    try {
      await _datasource.addProduct(basketItem);
      return right('محصول شما به سبد خرید اضافه شد');
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا در افزودن محصول به سبد خرید');
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItems() async {
    try {
      var basketItemList = await _datasource.getAllBasketItems();
      return right(basketItemList);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا در افزودن محصول به سبد خرید');
    }
  }
}
