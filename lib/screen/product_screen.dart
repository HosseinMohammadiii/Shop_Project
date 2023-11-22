import 'package:apple_shop/Class/colors.dart';
import 'package:apple_shop/Data/model/category.dart';
import 'package:apple_shop/Data/model/product.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatefulWidget {
  Categories categories;

  ProductListScreen(this.categories, {super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context)
        .add(ProductRequest('', widget.categories.id!));
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
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
                          Expanded(
                            child: Text(
                              widget.categories.title!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
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
                if (state is ProductLoadingState) ...[
                  const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator())),
                ],
                if (state is ProductResponseState) ...[
                  state.categoryProducts.fold(
                    (exeption) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(exeption),
                        ),
                      );
                    },
                    (categoryList) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return ProductItem(categoryList[index]);
                            },
                            childCount: categoryList.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            childAspectRatio: 2 / 2.4,
                            crossAxisSpacing: 20,
                            crossAxisCount: 2,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
