import 'package:apple_shop/Class/colors.dart';
import 'package:apple_shop/Data/repository/authentication_repository.dart';
import 'package:apple_shop/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class BasketShopScreen extends StatefulWidget {
  const BasketShopScreen({super.key});

  @override
  State<BasketShopScreen> createState() => _BasketShopScreenState();
}

class _BasketShopScreenState extends State<BasketShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Stack(
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
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 70),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 10,
                      (context, index) => productItem(context),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                  onPressed: () async {
                    await AuthenticationRepository()
                        .login('username', 'password');
                  },
                  child: const Text('ادامه فرایند خرید'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 80),
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
                  onPressed: () async {
                    AuthManager.logout();
                  },
                  child: const Text('logout'),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: AuthManager.authChangeNotifier,
              builder: (context, value, child) {
                if (value == null || value.isEmpty) {
                  return Text('شما وارد نشده اید');
                } else {
                  return Text('شما وارد شده اید');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget productItem(BuildContext context) {
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
                    const Text(
                      'آیفون 13 پرومکس دوسیم',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'گارانتی 18 ماه مدیا پردازش',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12,
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
                            fontSize: 14,
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
                        optionProductSelect(),
                        optionProductSelect(),
                        optionProductSelect(),
                        optionProductSelect(),
                        optionProductSelect(),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 40, right: 20, bottom: 20),
                child: Image.asset('images/iphone.png'),
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
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container optionProductSelect() {
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
      child: const Text(
        '128',
        style: TextStyle(
          fontFamily: 'SB',
          fontSize: 12,
        ),
      ),
    );
  }
}
