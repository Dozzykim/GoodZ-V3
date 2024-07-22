import 'package:flutter/material.dart';
import 'package:goodz/screen/user/join_screen.dart';
import 'package:goodz/screen/user/login_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("홈 화면"),
      ),
      body: TabBarView(
        controller: controller,
        children: const [JoinScreen(), LoginScreen()],
      ),
      bottomNavigationBar: TabBar(
        tabs: const [
          Tab(
            child: Text("회원가입"),
          ),
          Tab(
            child: Text("로그인"),
          ),
        ],
        controller: controller,
      ),
    );
  }
}
