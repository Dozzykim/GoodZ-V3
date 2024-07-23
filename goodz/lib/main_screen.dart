import 'package:flutter/material.dart';
import 'package:goodz/screen/user/join_screen.dart';
import 'package:goodz/screen/user/login_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("메인화면"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
        ),
      ),
    );
  }
}
