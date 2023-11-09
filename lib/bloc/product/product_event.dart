abstract class ProductEvent {}

class ProductRequest extends ProductEvent {
  String productId;
  ProductRequest(this.productId);
}
