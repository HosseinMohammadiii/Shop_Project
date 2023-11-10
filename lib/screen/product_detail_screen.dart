import 'dart:ui';

import 'package:apple_shop/Class/colors.dart';
import 'package:apple_shop/Data/model/product.dart';
import 'package:apple_shop/Data/repository/product_detail.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/widgets/product_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen(this.product, {super.key});
  Products product;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context)
        .add(ProductRequest(widget.product.id, widget.product.categoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ElevatedButton(
                      onPressed: () async {
                        IProductDetailRepository product = locator.get();
                        var response =
                            await product.getGallery(widget.product.id);
                        response.fold((l) {
                          print(l);
                        }, (r) {
                          r.forEach((element) {
                            print(element.imageUrl);
                          });
                        });
                      },
                      child: Text('click')),
                ),
                ProductDetailWidget(),
                getDetaliproduct(),
                if (state is ProductLoadingState) ...[
                  const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator())),
                ],
                if (state is ProductResponseState) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: colors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Image.asset(
                                'images/icon_apple_blue.png',
                              ),
                            ),
                            state.productresponsecategory.fold((exeption) {
                              return const Center(
                                child: Text(
                                  'اطلاعات محصول',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize: 16,
                                    color: colors.blue,
                                  ),
                                ),
                              );
                            }, (categoryTitle) {
                              return Text(
                                categoryTitle.title ?? 'دسته بندی',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 16,
                                  color: colors.blue,
                                ),
                              );
                            }),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: GestureDetector(
                                onTap: () {},
                                child: Image.asset('images/icon_back.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                if (state is ProductResponseState) ...[
                  state.productresponsImage.fold((exeption) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(exeption),
                      ),
                    );
                  }, (productImageList) {
                    return GalleryWidget(
                        widget.product.thumbnail, productImageList);
                  })
                ],
                if (state is ProductResponseState) ...[
                  state.productresponsVariant.fold((exeption) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(exeption),
                      ),
                    );
                  }, (productVariantList) {
                    return productsDetailWidget(
                      productVariantList: productVariantList,
                    );
                  })
                ],

                // if (state is HomeResponseState) ...[
                //   state.productresponsImage.fold((exeption) {
                //     return SliverToBoxAdapter(
                //       child: Center(
                //         child: Text(exeption),
                //       ),
                //     );
                //   }, (gallery) {
                //     return SliverToBoxAdapter(child: ProductDetailWidget());
                //   }),
                // ],
                // SliverToBoxAdapter(
                //   child: ProductDetailWidget(),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getDetaliproduct() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'انخاب رنگ',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 12,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 26,
                  height: 26,
                  margin: const EdgeInsets.only(left: 10, top: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'انتخاب حافظه داخلی',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 12,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 60,
                  height: 26,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 10, top: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colors.grey),
                    color: colors.white,
                  ),
                  child: const Text(
                    '128',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            boxCategoryInfoProduct(': مشخصات فتی'),
            boxCategoryInfoProduct(': توضیحات محصول'),
            Container(
              height: 46,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.asset('images/icon_left_categroy.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                          fontFamily: 'SB', fontSize: 12, color: colors.blue),
                    ),
                    const Spacer(),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          margin: const EdgeInsets.only(left: 10, right: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colors.red,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      ': نظرات کاربران',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                    color: colors.green,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 0.3,
                        spreadRadius: -6,
                        color: colors.green,
                        offset: Offset(0, -11),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 60),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'تومان',
                              style: TextStyle(
                                fontFamily: 'SM',
                                color: colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '49,800,000',
                                  style: TextStyle(
                                    color: colors.white,
                                    fontFamily: 'SM',
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Text(
                                  '48,800,000',
                                  style: TextStyle(
                                    fontFamily: 'SM',
                                    fontSize: 16,
                                    color: colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              height: 20,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colors.red,
                              ),
                              child: const Text(
                                '%5',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                    color: colors.blue,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 0.3,
                        spreadRadius: -6,
                        color: colors.blue,
                        offset: Offset(0, -11),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 60),
                      child: const Center(
                        child: Text(
                          'افزودن سبد خرید',
                          style: TextStyle(
                            fontFamily: 'SB',
                            color: colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget boxCategoryInfoProduct(String txt) {
    return Container(
      height: 46,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Image.asset('images/icon_left_categroy.png'),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'مشاهده',
              style:
                  TextStyle(fontFamily: 'SB', fontSize: 12, color: colors.blue),
            ),
            const Spacer(),
            Text(
              txt,
              style: const TextStyle(
                fontFamily: 'SM',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailWidget extends StatefulWidget {
  ProductDetailWidget({
    super.key,
  });
  // List<ProductImage> pImages;
  @override
  State<ProductDetailWidget> createState() => ProductDetailWidgetState();
}

class ProductDetailWidgetState extends State<ProductDetailWidget> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Text(
            'se آیفون 2022',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SB',
              fontSize: 16,
              color: colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            // width: 340,
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('images/icon_star.png'),
                      const Text(
                        '4.6',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 14,
                          height: 1.7,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                          height: 150, child: Image.asset('images/iphone.png')),
                      const Spacer(),
                      // CachedNetworkImage(
                      //     imageUrl: widget.pImages[selectedImage].image!),
                      Image.asset('images/icon_favorite_deactive.png'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 65),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImage = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(10),
                          width: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: const Border.fromBorderSide(
                              BorderSide(color: colors.grey),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset('images/iphone.png'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
