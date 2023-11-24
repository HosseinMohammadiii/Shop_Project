import 'package:apple_shop/Data/model/product.dart';

abstract class ProductEvent {}

class ProductRequest extends ProductEvent {
  String productsId;
  String categoreisId;
  ProductRequest(
    this.productsId,
    this.categoreisId,
  );
}

class ProductAddToBasket extends ProductEvent {
  Products products;
  ProductAddToBasket(this.products);
}
