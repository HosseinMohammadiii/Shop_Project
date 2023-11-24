import 'package:apple_shop/Data/model/card_item.dart';
import 'package:apple_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/auth_manager.dart';
import 'package:apple_shop/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('CardBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: globalNavigatorKey,
      home: Scaffold(
        body: SafeArea(
          child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => AuthBloc(),
                ),
                BlocProvider(
                  create: (context) => HomeBloc(),
                ),
                BlocProvider(
                  create: (context) => BasketBloc(),
                ),
              ],
              child: (AuthManager.readAuth().isEmpty)
                  ? const BottomNavigationScreen()
                  : const BottomNavigationScreen()),
        ),
      ),
    );
  }
}
