import 'package:apple_shop/Data/repository/product_detail.dart';
import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/di/di.dart';
import 'package:bloc/bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _productRepository = locator.get();

  ProductBloc() : super(InitionProductState()) {
    on<ProductRequest>((event, emit) async {
      emit(ProductLoadingState());
      var productImages = await _productRepository.getGallery(event.productId);
      var productVariant = await _productRepository.getProductVariants();
      emit(ProductResponseState(productImages, productVariant));
    });
  }
}
