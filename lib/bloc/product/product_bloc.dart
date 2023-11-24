import 'package:apple_shop/Data/model/card_item.dart';
import 'package:apple_shop/Data/repository/basket_repository.dart';
import 'package:apple_shop/Data/repository/product_detail.dart';
import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/di/di.dart';
import 'package:bloc/bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _productRepository = locator.get();
  final IBasketRepository _basketRepository = locator.get();

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
    on<ProductAddToBasket>(((event, emit) async {
      var basketItem = BasketItem(
        event.products.categoryId,
        event.products.collectionId,
        event.products.discount_price,
        event.products.id,
        event.products.name,
        event.products.price,
        event.products.thumbnail,
      );

      _basketRepository.addProductToBasket(basketItem);
    }));
  }
}
