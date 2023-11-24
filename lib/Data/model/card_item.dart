import 'package:hive/hive.dart';

part 'card_item.g.dart';

@HiveType(typeId: 0)
class BasketItem extends HiveObject {
  @HiveField(0)
  String categoryId;
  @HiveField(1)
  String collectionId;

  @HiveField(2)
  dynamic discount_price;

  @HiveField(3)
  String id;
  @HiveField(4)
  String name;

  @HiveField(5)
  dynamic price;

  @HiveField(6)
  String thumbnail;

  BasketItem(
    this.categoryId,
    this.collectionId,
    this.discount_price,
    this.id,
    this.name,
    this.price,
    this.thumbnail,
  );
}
