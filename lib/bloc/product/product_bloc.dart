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
      var productCategory =
          await _productRepository.getProductCategory(event.categoreisId);
      var productImages = await _productRepository.getGallery(event.productsId);
      var productVariant =
          await _productRepository.getProductVariants(event.productsId);

      var products = await _productRepository.getProducts(event.productsId);
      var categoryProducts =
          await _productRepository.getCategoryProducts(event.categoreisId);

      emit(ProductResponseState(
        productCategory,
        productImages,
        productVariant,
        products,
        categoryProducts,
      ));
    });
  }
}
