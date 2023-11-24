import 'package:apple_shop/Data/repository/basket_repository.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/di/di.dart';
import 'package:bloc/bloc.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository = locator.get();

  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>((event, emit) async {
      var basketItemList = await _basketRepository.getAllBasketItems();
      emit(BasketDataFetchedState(basketItemList));
    });
  }
}
