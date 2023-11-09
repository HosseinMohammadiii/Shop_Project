import 'package:apple_shop/Data/model/banner.dart';
import 'package:apple_shop/Data/model/category.dart';
import 'package:apple_shop/Data/model/gellery.dart';
import 'package:apple_shop/Data/model/product.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class InitionHomeState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<Banners>> response;
  Either<String, List<Categories>> categoryresponse;
  Either<String, List<Products>> productresponse;
  Either<String, List<Products>> productresponsehotest;
  Either<String, List<Products>> productresponsebestseller;
  HomeResponseState(
    this.response,
    this.categoryresponse,
    this.productresponse,
    this.productresponsehotest,
    this.productresponsebestseller,
  );
}
