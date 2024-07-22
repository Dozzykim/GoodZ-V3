import 'package:flutter/material.dart';
import 'package:goodz/screen/user/purchase_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          const Text(
            "로그인",
            style: TextStyle(fontSize: 32.0),
          ),
          const SizedBox(
            height: 50,
          ),
          const TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "아이디",
                hintText: "아이디를 입력해주세요"),
          ),
          const SizedBox(
            height: 20,
          ),
          const TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "비밀번호",
                hintText: "비밀번호를 입력해주세요"),
          ),
          const SizedBox(
            height: 20,
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 아이디 저장
                Row(
                  children: [
                    Checkbox(
                        value: false,
                        onChanged: (bool? value) {
                          print("아이디 저장 여부 : ${value}");
                          // TODO : state 업데이트
                        }),
                    const Text("아이디 저장")
                  ],
                ),
                // 자동 로그인
                Row(
                  children: [
                    Checkbox(
                        value: false,
                        onChanged: (bool? value) {
                          print("자동 로그인 여부 : ${value}");
                          // TODO : state 업데이트
                        }),
                    const Text("자동 로그인")
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          // 버튼
          ElevatedButton(
            onPressed: () {
              // 임시로 메인화면 진입
              print("클릭");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PurchaseScreen()
                )
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // 배경색
                foregroundColor: Colors.white, // 폰트색
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0) // 테두리 곡률
                    ),
                // 버튼의 최소 크기 - 가로, 세로 크기
                // double.infinity : 디바이스의 최대크기로 설정
                minimumSize: const Size(double.infinity, 40.0)),
            child: const Text("로그인"),
          )
        ],
      ),
    );
  }
}
