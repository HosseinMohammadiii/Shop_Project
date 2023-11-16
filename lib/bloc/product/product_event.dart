abstract class ProductEvent {}

class ProductRequest extends ProductEvent {
  String productsId;
  String categoreisId;
  ProductRequest(
    this.productsId,
    this.categoreisId,
  );
}
