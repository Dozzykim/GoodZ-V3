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
      initialRoute: '/main',
      routes: {
        '/main': (context) => MainScreen(),
        '/user/login': (context) => LoginScreen(),
        '/user/join': (context) => JoinScreen(),
        '/user/mypage': (context) => MyPageScreen(),
        '/products': (context) => ProductsScreen(),
        '/buy': (context) => BuyScreen(),
        '/buy/complete': (context) => BuyCompleteScreen()
      },

      // 상품상세 페이지 라우트 관련
      // 상품별로 동적페이지 생성해야함!!!!!
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

void main() {
  runApp(const MyApp());
}
