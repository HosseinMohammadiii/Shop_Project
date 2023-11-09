import 'package:apple_shop/Data/datasource/authentication_daatasource.dart';
import 'package:apple_shop/Data/datasource/category_datasource.dart';
import 'package:apple_shop/Data/datasource/product_datasource.dart';
import 'package:apple_shop/Data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/Data/repository/authentication_repository.dart';
import 'package:apple_shop/Data/repository/category_repository.dart';
import 'package:apple_shop/Data/repository/banner_repository.dart';
import 'package:apple_shop/Data/datasource/banner_datasource.dart';
import 'package:apple_shop/Data/repository/product_detail.dart';
import 'package:apple_shop/Data/repository/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //components
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  //datasources
  locator
      .registerFactory<IAuthenticationDataSource>(() => AuthenticationRemot());
  locator
      .registerFactory<ICategoryDatasource>(() => CategoryRemoteDatasource());
  locator.registerFactory<IBannerDatasource>(() => BannerRemoteDatasource());
  locator
      .registerFactory<IProductsDatasource>(() => ProductsRemoteDatasource());
  locator.registerFactory<IDetailProductDatasource>(
      () => ProductDetailRemoteDatasource());

  //repositories
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductsRepository>(() => ProductRepository());
  locator.registerFactory<IProductDetailRepository>(
      () => ProductDetailRepository());
}