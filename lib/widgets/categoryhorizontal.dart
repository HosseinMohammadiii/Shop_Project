import 'package:apple_shop/Class/colors.dart';
import 'package:apple_shop/Data/model/category.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/screen/product_screen.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalCategory extends StatelessWidget {
  HorizontalCategory({super.key, required this.list});
  List<Categories> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'دسته بندی',
            style: TextStyle(
              fontFamily: 'SB',
              color: colors.grey,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            reverse: true,
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => ProductBloc(),
                        child: ProductListScreen(
                          list[index],
                        ),
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          height: 56,
                          width: 56,
                          decoration: ShapeDecoration(
                            color: Color(
                                int.parse('ff${list[index].color}', radix: 16)),
                            shadows: const [
                              BoxShadow(
                                color: Colors.black,
                                blurStyle: BlurStyle.normal,
                                blurRadius: 25,
                                spreadRadius: -15,
                                offset: Offset(0.0, 15),
                              ),
                            ],
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                          child: CachedImage(
                            imageUrl: list[index].icon,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      list[index].title!,
                      style: const TextStyle(
                        fontFamily: 'SB',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
