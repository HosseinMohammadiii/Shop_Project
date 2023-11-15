import 'dart:ui';

import 'package:apple_shop/Class/colors.dart';
import 'package:apple_shop/Data/model/gellery.dart';
import 'package:apple_shop/Data/model/product_variant.dart';
import 'package:apple_shop/Data/model/variant.dart';
import 'package:apple_shop/Data/model/variant_type.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class productsDetailWidget extends StatefulWidget {
  productsDetailWidget({
    super.key,
    required this.productVariantList,
  });
  List<ProductVariant> productVariantList;

  @override
  State<productsDetailWidget> createState() => _productsDetailWidgetState();
}

class _productsDetailWidgetState extends State<productsDetailWidget> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Center(
            //   child: Text(
            //     widget.productVariantList[0].variantType.title!,
            //     textAlign: TextAlign.center,
            //     style: const TextStyle(
            //       fontFamily: 'SB',
            //       fontSize: 16,
            //       color: colors.black,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            for (var productVariant in widget.productVariantList) ...{
              if (productVariant.variantList.isNotEmpty) ...{
                if (productVariant.variantType.type ==
                    VariantTypeEnum.COLOR) ...{
                  Text(
                    productVariant.variantType.title!,
                    style: const TextStyle(
                      fontFamily: 'SM',
                      fontSize: 12,
                    ),
                  ),
                  ColorVariantList(productVariant.variantList),
                },
                const SizedBox(
                  height: 15,
                ),
                if (productVariant.variantType.type ==
                    VariantTypeEnum.STORAGE) ...{
                  Text(
                    productVariant.variantType.title!,
                    style: const TextStyle(
                      fontFamily: 'SM',
                      fontSize: 12,
                    ),
                  ),
                  MemoryVariantList(productVariant.variantList),
                },
              },
            },
            const SizedBox(
              height: 20,
            ),
            // ProductDescription(),

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
}

class ProductDescription extends StatefulWidget {
  String productDescription;
  ProductDescription(
    this.productDescription, {
    super.key,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              height: 46,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset('images/icon_left_categroy.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'مشاهده',
                    style: TextStyle(
                        fontFamily: 'sb', fontSize: 12, color: colors.blue),
                  ),
                  const Spacer(),
                  const Text(
                    ': توضییحات محصول',
                    style: TextStyle(fontFamily: 'sm'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Text(
                  widget.productDescription,
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontFamily: 'sm',
                    fontSize: 16,
                    height: 1.8,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  List<ProductImage> productImageList;
  String? defaultProductThumbnail;

  int selectedItem = 0;
  GalleryWidget(
    this.defaultProductThumbnail,
    this.productImageList, {
    Key? key,
  }) : super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: Container(
          height: 284,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/icon_star.png',
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text(
                            '۴.۶',
                            style: TextStyle(fontFamily: 'sm', fontSize: 12),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: CachedImage(
                            imageUrl: (widget.productImageList.isEmpty)
                                ? widget.defaultProductThumbnail
                                : widget.productImageList[widget.selectedItem]
                                    .imageUrl),
                      ),
                      const Spacer(),
                      Image.asset('images/icon_favorite_deactive.png')
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 44, right: 44, top: 4),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productImageList.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.selectedItem = index;
                            });
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            margin: const EdgeInsets.only(left: 20),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(width: 1, color: colors.grey),
                            ),
                            child: CachedImage(
                              imageUrl: widget.productImageList[index].imageUrl,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              }
            ],
          ),
        ),
      ),
    );
  }
}

class ImageGallary extends StatefulWidget {
  ImageGallary(this.productImage, this.selectedItem, {super.key});
  List<ProductImage> productImage;
  int selectedItem;
  @override
  State<ImageGallary> createState() => _ImageGallaryState();
}

class _ImageGallaryState extends State<ImageGallary> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                widget.selectedItem = index;
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
              child: CachedImage(
                imageUrl: widget.productImage[index].imageUrl,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ColorVariantList extends StatefulWidget {
  ColorVariantList(this.variantList, {super.key});
  List<Variant> variantList;
  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        itemCount: widget.variantList.length,
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (context, index) {
          String categoryColor = 'ff${widget.variantList[index].value}';
          int hexColor = int.parse(categoryColor, radix: 16);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              width: 30,
              height: 30,
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(left: 10, top: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: (selectedIndex == index)
                    ? Border.all(
                        width: 1,
                        color: colors.blue,
                        strokeAlign: BorderSide.strokeAlignOutside)
                    : Border.all(width: 2, color: colors.white),
                color: colors.white,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(hexColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MemoryVariantList extends StatefulWidget {
  MemoryVariantList(this.variantList, {super.key});

  List<Variant> variantList;

  @override
  State<MemoryVariantList> createState() => _MemoryVariantListState();
}

class _MemoryVariantListState extends State<MemoryVariantList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: ListView.builder(
        itemCount: widget.variantList.length,
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              width: 60,
              height: 26,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, top: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: (selectedIndex == index)
                    ? Border.all(
                        width: 2,
                        color: colors.blue,
                        strokeAlign: BorderSide.strokeAlignOutside)
                    : Border.all(width: 1, color: colors.grey),
                color: colors.white,
              ),
              child: Text(
                widget.variantList[index].value!,
                style: const TextStyle(
                  fontFamily: 'SB',
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
