import 'package:apple_shop/Data/datasource/banner_datasource.dart';
import 'package:apple_shop/Data/model/banner.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exeption.dart';
import 'package:dartz/dartz.dart';

abstract class IBannerRepository {
  Future<Either<String, List<Banners>>> getBanner();
}

class BannerRepository extends IBannerRepository {
  final IBannerDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Banners>>> getBanner() async {
    try {
      var response = await _datasource.getBanner();
      return Right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
