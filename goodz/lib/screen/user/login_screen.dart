import 'package:flutter/material.dart';
import 'package:goodz/provider/user_provider.dart';
import 'package:goodz/screen/products/products_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _performLogin(userProvider);
                // 서버연결 전 임시방편으로 이동처리
                //  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen()));
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  // 로그인 메서드
  void _performLogin(UserProvider userProvider) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    print('Username: $username');
    print('Password: $password');

    bool loginSuccessful = await userProvider.login(username, password);
    if (loginSuccessful) {
      print('로그인 여부 : ${userProvider.isLogin}');
      await userProvider.getUserInfo();

      print(userProvider.userInfo);
      Navigator.pushReplacementNamed(context, '/products');
    } else {
      _showLoginErrorDialog();
    }
  }

  void _showLoginErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text('아이디 혹은 비밀번호를 다시 확인해주세요.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
