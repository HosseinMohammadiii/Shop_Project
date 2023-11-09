import 'package:apple_shop/Class/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImage extends StatelessWidget {
  CachedImage({super.key, this.imageUrl});
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: CachedNetworkImage(
        imageUrl: imageUrl ??
            'http://startflutter.ir/api/files/f5pm8kntkfuwbn1/hesdw8xm91d17bw/rectangle_64_iEmkWhvcch.png',
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Container(
          color: colors.red,
        ),
        placeholder: (context, url) => Container(
          color: colors.grey,
        ),
      ),
    );
  }
}
