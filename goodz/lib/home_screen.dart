import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goodz/provider/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('메인화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (userProvider.isLogin) ...[
              Text('환영합니다, ${userProvider.userInfo.userId}님'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  userProvider.logout();
                  Navigator.pushReplacementNamed(context, '/user/login');
                },
                child: const Text('로그아웃'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/products');
                },
                child: const Text('상품목록으로 가기'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user/login');
                },
                child: const Text('로그인'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user/join');
                },
                child: const Text('회원가입'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
