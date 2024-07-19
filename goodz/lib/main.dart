import 'package:flutter/material.dart';
import 'package:goodz/main_screen.dart';
import 'package:goodz/screen/buy/buy_complete_screen.dart';
import 'package:goodz/screen/buy/buy_screen.dart';
import 'package:goodz/screen/products/product_detail_screen.dart';
import 'package:goodz/screen/products/products_screen.dart';
import 'package:goodz/screen/user/join_screen.dart';
import 'package:goodz/screen/user/login_screen.dart';
import 'package:goodz/screen/user/mypage_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      routes: {
        '/main' : (context) => MainScreen(),
        '/user/login' : (context) => LoginScreen(),
        '/user/join' : (context) => JoinScreen(),
        '/user/mypage' : (context) => MyPageScreen(),
        '/products' : (context) => ProductsScreen(),
        '/products/detail' : (context) => ProductDetailScreen(),
        '/buy' : (context) => BuyScreen(),
        '/buy/complete' : (context) => BuyCompleteScreen()
      },
    );
  }
}