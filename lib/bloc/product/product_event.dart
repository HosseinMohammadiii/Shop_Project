abstract class ProductEvent {}

class ProductRequest extends ProductEvent {
  String productId;
  String categoryId;
  ProductRequest(this.productId, this.categoryId);
}
