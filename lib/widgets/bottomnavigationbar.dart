import 'dart:ui';

import 'package:apple_shop/Class/colors.dart';
import 'package:apple_shop/Class/screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedItem = 3;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: BottomNavigationBar(
              selectedLabelStyle: const TextStyle(
                fontFamily: 'SB',
                fontSize: 10,
                color: colors.blue,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'SB',
                fontSize: 10,
                color: colors.black,
              ),
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                    icon: _selectedItem == 0
                        ? iconNavigation('images/icon_profile_active.png')
                        : iconNavigation('images/icon_profile.png'),
                    label: 'حساب کاربری'),
                BottomNavigationBarItem(
                    icon: _selectedItem == 1
                        ? iconNavigation('images/icon_basket_active.png')
                        : iconNavigation('images/icon_basket.png'),
                    label: 'سبد خرید'),
                BottomNavigationBarItem(
                    icon: _selectedItem == 2
                        ? iconNavigation('images/icon_category_active.png')
                        : iconNavigation('images/icon_category.png'),
                    label: 'دسته بندی'),
                BottomNavigationBarItem(
                    icon: _selectedItem == 3
                        ? iconNavigation('images/icon_home_active.png')
                        : iconNavigation('images/icon_home.png'),
                    label: 'خانه'),
              ],
              currentIndex: _selectedItem,
              selectedItemColor: colors.blue,
              onTap: (index) {
                setState(() {
                  _selectedItem = index;
                });
              },
            ),
          ),
        ),
        body: Center(
          child: Screen.elementAt(_selectedItem),
        ),
      ),
    );
  }

  Container iconNavigation(String img) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: colors.blue,
            blurRadius: 20,
            spreadRadius: -8,
            offset: Offset(0.0, 13),
          ),
        ],
      ),
      child: Image.asset(img),
    );
  }
}
