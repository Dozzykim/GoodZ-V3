import 'package:flutter/material.dart';
import 'package:goodz/screen/user/purchase_screen.dart';
import 'package:provider/provider.dart';
import 'package:goodz/main_screen.dart';
import 'package:goodz/screen/user/join_screen.dart';
import 'package:goodz/screen/user/login_screen.dart';
import 'package:goodz/home_screen.dart';
import 'package:goodz/provider/user_provider.dart';
import 'package:goodz/screen/products/products_screen.dart';
import 'package:goodz/screen/buy/buy_complete_screen.dart';
import 'package:goodz/screen/buy/buy_screen.dart';
import 'package:goodz/screen/products/product_detail_screen.dart';
import 'package:goodz/screen/user/mypage_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goodz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      initialRoute: '/main',
      routes: {
        '/': (context) => const HomeScreen(), // 로그인 성공 시 홈 화면으로 이동
        '/main': (context) => const MainScreen(),
        '/user/login': (context) => const LoginScreen(),
        // '/user/join': (context) => const JoinScreen(),
        '/user/mypage': (context) => const MyPageScreen(),
        '/user/purchase': (context) => PurchaseScreen(),
        '/products': (context) => const ProductsScreen(),
        '/buy': (context) => const BuyScreen(),
        '/buy/complete': (context) => const BuyCompleteScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/products/detail') {
          final arguments = settings.arguments as Map<String, dynamic>;
          final pNo = arguments['pNo'] as int;
          final productName = arguments['productName'] as String;
          final price = arguments['price'] as int;
          final imgUrl = arguments['imgUrl'] as String;

          return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              pNo: pNo,
              productName: productName,
              price: price,
              imgUrl: imgUrl,
            ),
          );
        }
        return null;
      },
    );
  }
}
