import 'package:apple_shop/Class/colors.dart';
import 'package:apple_shop/Data/model/card_item.dart';
import 'package:apple_shop/Data/model/product.dart';
import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/util/extension/color_extension.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class BasketShopScreen extends StatefulWidget {
  const BasketShopScreen({super.key});

  @override
  State<BasketShopScreen> createState() => _BasketShopScreenState();
}

class _BasketShopScreenState extends State<BasketShopScreen> {
  @override
  void initState() {
    BlocProvider.of<BasketBloc>(context).add(BasketFetchFromHiveEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<BasketItem>('CardBox');

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
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
                                padding: const EdgeInsets.only(left: 10),
                                child: Image.asset(
                                  'images/icon_apple_blue.png',
                                ),
                              ),
                              const Expanded(
                                child: Text(
                                  'سبد خرید',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize: 16,
                                    color: colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (state is BasketDataFetchedState) ...[
                      state.basketItemList.fold(
                        (exeption) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(exeption),
                            ),
                          );
                        },
                        (productBasket) {
                          return SliverPadding(
                            padding: const EdgeInsets.only(bottom: 70),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: productBasket.length,
                                (context, index) =>
                                    productItem(context, productBasket[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 53,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 17,
                          ),
                          backgroundColor: colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onPressed: () async {},
                      child: const Text('ادامه فرایند خرید'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget productItem(BuildContext context, BasketItem basketItem) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      height: 250,
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      basketItem.name,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'گارانتی 18 ماهه مدیا پردازش',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 10,
                        color: colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 20,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.red,
                          ),
                          child: const Text(
                            '%3',
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 12,
                              color: colors.white,
                            ),
                          ),
                        ),
                        const Text(
                          'تومان',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                            color: colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text(
                          '46,000,000',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                            color: colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      runSpacing: 2,
                      alignment: WrapAlignment.end,
                      spacing: 5,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 60,
                            height: 22,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 10, top: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: colors.grey),
                              color: colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  'حذف',
                                  style: TextStyle(
                                    fontFamily: 'SM',
                                    fontSize: 12,
                                    color: colors.red,
                                  ),
                                ),
                                Image.asset(
                                  'images/icon_trash.png',
                                  color: colors.red,
                                ),
                              ],
                            ),
                          ),
                        ),
                        optionProductSelect('vcvvc', '4287f5'),
                        // optionProductSelect(''),
                        // optionProductSelect(''),
                        // optionProductSelect(''),
                        // optionProductSelect(''),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 20, right: 20, bottom: 20),
                child: SizedBox(
                  //width: 10,
                  height: 110,
                  child: CachedImage(
                    imageUrl: basketItem.thumbnail,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          DottedLine(
            dashColor: colors.grey.withOpacity(0.5),
            dashLength: 8.0,
            lineLength: MediaQuery.sizeOf(context).width / 1.1,
            lineThickness: 3.0,
            dashGapLength: 3.0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تومان',
                  style: TextStyle(
                    fontFamily: 'SM',
                    fontSize: 12,
                    color: colors.grey,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '59,000,000',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container optionProductSelect(String title, String color) {
    return Container(
      width: 60,
      height: 22,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 10, top: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.grey),
        color: colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (color.isNotEmpty) ...{
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.parsToColor(),
              ),
            ),
          },
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'SM',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
