import 'package:apple_shop/Data/model/card_item.dart';
import 'package:dartz/dartz.dart';

abstract class BasketState {}

class BasketInitState extends BasketState {}

class BasketDataFetchedState extends BasketState {
  Either<String, List<BasketItem>> basketItemList;
  BasketDataFetchedState(this.basketItemList);
}
