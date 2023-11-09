import 'package:apple_shop/Data/repository/banner_repository.dart';
import 'package:apple_shop/Data/repository/category_repository.dart';
import 'package:apple_shop/Data/repository/product_detail.dart';
import 'package:apple_shop/Data/repository/product_repository.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/di/di.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _repository = locator.get();
  final ICategoryRepository _categoryRepository = locator.get();
  final IProductsRepository _productRepository = locator.get();
  HomeBloc() : super(InitionHomeState()) {
    on<HomeRequest>((event, emit) async {
      emit(HomeLoadingState());
      var response = await _repository.getBanner();
      var categoryresponse = await _categoryRepository.getCategories();
      var productresponse = await _productRepository.getProducts();
      var productresponsehotest = await _productRepository.getHotest();
      var productresponsebestseller = await _productRepository.getBestseller();

      emit(HomeResponseState(
        response,
        categoryresponse,
        productresponse,
        productresponsehotest,
        productresponsebestseller,
      ));
    });
  }
}
