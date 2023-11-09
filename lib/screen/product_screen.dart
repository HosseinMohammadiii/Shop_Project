import 'package:apple_shop/Class/colors.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                          'پر فروش ترین ها',
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
            // SliverPadding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   sliver: SliverGrid(
            //     delegate: SliverChildBuilderDelegate((context, index) {
            //       return const ProductItem();
            //     }),
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       mainAxisSpacing: 20,
            //       childAspectRatio: 2 / 2.2,
            //       crossAxisSpacing: 20,
            //       crossAxisCount: 2,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
