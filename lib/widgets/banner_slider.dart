import 'package:apple_shop/Class/colors.dart';
import 'package:apple_shop/Data/model/banner.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerScreen extends StatefulWidget {
  BannerScreen({super.key, required this.listBanners});

  List<Banners> listBanners;
  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  PageController controller =
      PageController(viewportFraction: 0.9, initialPage: 2);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            controller: controller,
            itemCount: widget.listBanners.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedImage(
                    imageUrl: widget.listBanners[index].thumbnail,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const ExpandingDotsEffect(
              expansionFactor: 5,
              dotHeight: 8,
              dotWidth: 8,
              dotColor: Colors.white,
              activeDotColor: colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
