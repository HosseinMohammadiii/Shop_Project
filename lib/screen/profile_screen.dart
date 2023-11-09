import 'package:apple_shop/Class/colors.dart';
import 'package:apple_shop/widgets/category_icon_chip.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                        'حساب کاربری',
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
            const SizedBox(
              height: 10,
            ),
            const Text(
              'حسین محمدی',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 16,
              ),
            ),
            const Text(
              '0913...7182',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 12,
              ),
            ),
            const Wrap(
              alignment: WrapAlignment.end,
              runSpacing: 20,
              spacing: 16,
              children: [
                CategoryItemChip(),
                CategoryItemChip(),
                CategoryItemChip(),
                CategoryItemChip(),
                CategoryItemChip(),
                CategoryItemChip(),
                CategoryItemChip(),
                CategoryItemChip(),
                CategoryItemChip(),
                CategoryItemChip(),
              ],
            ),
            const Spacer(),
            const Text(
              'اپل شاپ',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 10,
                color: colors.grey,
              ),
            ),
            const Text(
              'v-1.0.00',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 10,
                color: colors.grey,
              ),
            ),
            const Text(
              'Instagram.com/hosseinmohammadi.dev',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 10,
                color: colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
