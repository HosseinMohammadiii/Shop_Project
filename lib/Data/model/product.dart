class Products {
  String categoryId;
  String collectionId;
  String description;

  dynamic discount_price;

  String id;
  String name;
  String popularity;

  dynamic price;
  dynamic quantity;

  String thumbnail;

  Products(
    this.categoryId,
    this.collectionId,
    this.description,
    this.discount_price,
    this.id,
    this.name,
    this.popularity,
    this.price,
    this.quantity,
    this.thumbnail,
  );
  factory Products.fromMapJson(Map<String, dynamic> jsonObject) {
    return Products(
      jsonObject['category'],
      jsonObject['collectionId'],
      jsonObject['description'],
      jsonObject['discount_price'],
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['popularity'],
      jsonObject['price'],
      jsonObject['quantity'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
