import 'package:apple_shop/Class/colors.dart';
import 'package:apple_shop/Data/model/product.dart';
import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/screen/product_detail_screen.dart';
import 'package:apple_shop/widgets/banner_slider.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:apple_shop/widgets/categoryhorizontal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: colors.background,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: searchBarWidget(controller, focusNode),
              ),
              if (state is HomeLoadingState) ...[
                const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator())),
              ],
              if (state is HomeResponseState) ...[
                state.response.fold((exeption) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(exeption),
                    ),
                  );
                }, (bannerlist) {
                  return SliverToBoxAdapter(
                    child: BannerScreen(listBanners: bannerlist),
                  );
                }),
                state.categoryresponse.fold((exeption) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(exeption),
                    ),
                  );
                }, (categorylist) {
                  return SliverToBoxAdapter(
                    child: HorizontalCategory(list: categorylist),
                  );
                }),
                SliverToBoxAdapter(
                  child:
                      widgetProductTextCategory('مشاهده همه', 'پرفروش ترین ها'),
                ),
                state.productresponsehotest.fold((exeption) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(exeption),
                    ),
                  );
                }, (listProduct) {
                  return _getMostViewedProduct(listProduct);
                }),
                SliverToBoxAdapter(
                  child: widgetProductTextCategory(
                      'مشاهده همه', 'پر بازدید ترین ها'),
                ),
                state.productresponsebestseller.fold((exeption) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(exeption),
                    ),
                  );
                }, (listProduct) {
                  return _getMostViewedProduct(listProduct);
                }),
              ],
            ],
          );
        },
      ),
    );
  }

  //Widget Search Bar
  Widget searchBarWidget(
      TextEditingController controller, FocusNode _focusNode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: 380,
          child: TextField(
            controller: controller,
            focusNode: _focusNode,
            style: const TextStyle(height: 0.7),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset('images/icon_search.png'),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset('images/icon_apple_blue.png'),
              ),
              hintText: 'جستوجوی محصولات',
              hintStyle: const TextStyle(
                color: colors.grey,
                fontFamily: 'SM',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
            maxLines: null,
            onTapOutside: (event) {
              _focusNode.unfocus();
            },
          ),
        ),
      ),
    );
  }

  Widget widgetProductTextCategory(String txt1, String txt2) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Image.asset(
                  'images/icon_left_categroy.png',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    txt1,
                    style: const TextStyle(
                      fontFamily: 'SB',
                      color: colors.blue,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            txt2,
            style: const TextStyle(
              fontFamily: 'SB',
              color: colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _getMostViewedProduct extends StatelessWidget {
  final List<Products> productList;
  _getMostViewedProduct(
    this.productList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 220,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            reverse: true,
            itemCount: productList.length,
            itemBuilder: ((context, index) {
              return ProductItem(productList[index]);
            })),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  ProductItem(this.product, {super.key});
  Products product;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ProductBloc(),
                  child: ProductDetailScreen(product),
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: 145,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).aspectRatio * 15,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: Container(),
                    ),
                    SizedBox(
                      height: 100,
                      child: CachedImage(
                        imageUrl: product.thumbnail,
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 5,
                        child: Image.asset('images/active_fav_product.png')),
                    Positioned(
                      bottom: 0,
                      left: 5,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        height: 20,
                        width: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colors.red,
                        ),
                        child: Text(
                          getDiscountPrice(),
                          style: const TextStyle(
                            fontFamily: 'SB',
                            fontSize: 12,
                            color: colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    product.name,
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'SM',
                      fontSize: 14,
                    ),
                  ),
                ),
                //const Spacer(),
                SizedBox(
                  height: MediaQuery.sizeOf(context).aspectRatio * 20,
                ),
                Container(
                  height: 53,
                  decoration: const BoxDecoration(
                    color: colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.blue,
                        blurRadius: 25,
                        spreadRadius: -16,
                        offset: Offset(0.0, 15),
                      ),
                    ],
                  ),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${product.price - product.discount_price}',
                            style: const TextStyle(
                              color: colors.white,
                              fontFamily: 'SM',
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            '${product.price}',
                            style: const TextStyle(
                              fontFamily: 'SM',
                              fontSize: 16,
                              color: colors.white,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'images/icon_right_arrow_cricle.png',
                        scale: 1.5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDiscountPrice() {
    return '%${((-product.discount_price * 100) / (product.price)).toStringAsFixed(0)}';
  }
}

// import 'package:apple_shop/Class/colors.dart';
// import 'package:apple_shop/Data/model/product.dart';
// import 'package:apple_shop/bloc/home/home_bloc.dart';
// import 'package:apple_shop/bloc/home/home_event.dart';
// import 'package:apple_shop/bloc/home/home_state.dart';
// import 'package:apple_shop/bloc/product/product_bloc.dart';
// import 'package:apple_shop/screen/product_detail_screen.dart';
// import 'package:apple_shop/widgets/banner_slider.dart';
// import 'package:apple_shop/widgets/cached_image.dart';
// import 'package:apple_shop/widgets/categoryhorizontal.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     BlocProvider.of<HomeBloc>(context).add(HomeRequest());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     FocusNode focusNode = FocusNode();
//     TextEditingController controller = TextEditingController();
//     return Scaffold(
//       backgroundColor: colors.background,
//       body: BlocBuilder<HomeBloc, HomeState>(
//         builder: (context, state) {
//           return CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: searchBarWidget(controller, focusNode),
//               ),
//               if (state is HomeLoadingState) ...[
//                 const SliverFillRemaining(
//                     child: Center(child: CircularProgressIndicator())),
//               ],
//               if (state is HomeResponseState) ...[
//                 state.response.fold((exeption) {
//                   return Center(
//                     child: Text(exeption),
//                   );
//                 }, (bannerlist) {
//                   return SliverToBoxAdapter(
//                     child: BannerScreen(listBanners: bannerlist),
//                   );
//                 }),
//                 state.categoryresponse.fold((exeption) {
//                   return Center(
//                     child: Text(exeption),
//                   );
//                 }, (categorylist) {
//                   return SliverToBoxAdapter(
//                     child: HorizontalCategory(list: categorylist),
//                   );
//                 }),
//                 SliverToBoxAdapter(
//                   child:
//                       widgetProductTextCategory('مشاهده همه', 'پرفروش ترین ها'),
//                 ),
//                 state.productresponsehotest.fold((exeption) {
//                   return Center(
//                     child: Text(exeption),
//                   );
//                 }, (listProduct) {
//                   return SliverToBoxAdapter(
//                     child: ProductItem(products: listProduct),
//                   );
//                 }),
//                 SliverToBoxAdapter(
//                   child: widgetProductTextCategory(
//                       'مشاهده همه', 'پر بازدید ترین ها'),
//                 ),
//                 state.productresponsebestseller.fold((exeption) {
//                   return SliverToBoxAdapter(
//                     child: Center(
//                       child: Text(exeption),
//                     ),
//                   );
//                 }, (listProduct) {
//                   return SliverToBoxAdapter(
//                     child: ProductItem(products: listProduct),
//                   );
//                 }),
//               ],
//             ],
//           );
//         },
//       ),
//     );
//   }

//   //Widget Search Bar
//   Widget searchBarWidget(
//       TextEditingController controller, FocusNode _focusNode) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Container(
//           width: 380,
//           child: TextField(
//             controller: controller,
//             focusNode: _focusNode,
//             style: const TextStyle(height: 0.7),
//             textInputAction: TextInputAction.search,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.white,
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Image.asset('images/icon_search.png'),
//               ),
//               suffixIcon: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Image.asset('images/icon_apple_blue.png'),
//               ),
//               hintText: 'جستوجوی محصولات',
//               hintStyle: const TextStyle(
//                 color: colors.grey,
//                 fontFamily: 'SM',
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//             maxLines: null,
//             onTapOutside: (event) {
//               _focusNode.unfocus();
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget widgetProductTextCategory(String txt1, String txt2) {
//     return Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           child: GestureDetector(
//             onTap: () {},
//             child: Row(
//               children: [
//                 Image.asset(
//                   'images/icon_left_categroy.png',
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: Text(
//                     txt1,
//                     style: const TextStyle(
//                       fontFamily: 'SB',
//                       color: colors.blue,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const Spacer(),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Text(
//             txt2,
//             style: const TextStyle(
//               fontFamily: 'SB',
//               color: colors.grey,
//               fontSize: 12,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ProductItem extends StatelessWidget {
//   ProductItem( this.product,{super.key,required this.products});
//   List<Products> products;
//   Products product;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 210,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: ListView.builder(
//           reverse: true,
//           scrollDirection: Axis.horizontal,
//           itemCount: products.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BlocProvider(
//                       create: (context) => ProductBloc(),
//                       child: ProductDetailScreen(product),
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 15),
//                 width: 145,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: colors.white,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     SizedBox(
//                       height: MediaQuery.sizeOf(context).aspectRatio * 15,
//                     ),
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Positioned(
//                           child: Container(),
//                         ),
//                         SizedBox(
//                           height: 100,
//                           child: CachedImage(
//                             imageUrl: products[index].thumbnail,
//                           ),
//                         ),
//                         Positioned(
//                             top: 0,
//                             right: 5,
//                             child:
//                                 Image.asset('images/active_fav_product.png')),
//                         Positioned(
//                           bottom: 0,
//                           left: 5,
//                           child: Container(
//                             alignment: Alignment.center,
//                             padding: const EdgeInsets.symmetric(horizontal: 2),
//                             height: 20,
//                             width: 26,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: colors.red,
//                             ),
//                             child: Text(
//                               getDiscountPrice(index),
//                               style: const TextStyle(
//                                 fontFamily: 'SB',
//                                 fontSize: 12,
//                                 color: colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Text(
//                         products[index].name,
//                         textDirection: TextDirection.rtl,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontFamily: 'SM',
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     //const Spacer(),
//                     SizedBox(
//                       height: MediaQuery.sizeOf(context).aspectRatio * 20,
//                     ),
//                     Container(
//                       height: 53,
//                       decoration: const BoxDecoration(
//                         color: colors.blue,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(15),
//                           bottomRight: Radius.circular(15),
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: colors.blue,
//                             blurRadius: 25,
//                             spreadRadius: -16,
//                             offset: Offset(0.0, 15),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           const Text(
//                             'تومان',
//                             style: TextStyle(
//                               fontFamily: 'SM',
//                               color: colors.white,
//                               fontSize: 12,
//                             ),
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '${products[index].price - products[index].discount_price}',
//                                 style: const TextStyle(
//                                   color: colors.white,
//                                   fontFamily: 'SM',
//                                   fontSize: 12,
//                                   decoration: TextDecoration.lineThrough,
//                                 ),
//                               ),
//                               Text(
//                                 '${products[index].price}',
//                                 style: const TextStyle(
//                                   fontFamily: 'SM',
//                                   fontSize: 16,
//                                   color: colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Image.asset(
//                             'images/icon_right_arrow_cricle.png',
//                             scale: 1.5,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   getDiscountPrice(int index) {
//     return '%${((-products[index].discount_price * 100) / (products[index].price)).toStringAsFixed(0)}';
//   }
// }