import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:goodz/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider extends ChangeNotifier {
  User _userInfo = User();
  bool _loginStat = false;

  User get userInfo => _userInfo;
  bool get isLogin => _loginStat;

  final storage = const FlutterSecureStorage();


  // 로그인 처리
  Future<bool> login(String username, String password) async {
    const url = 'http://10.0.2.2:8080/login';
    final requestUrl = Uri.parse('$url?username=$username&password=$password');
    try {
      final response =
          await http.get(requestUrl).timeout(Duration(seconds: 20));

      if (response.statusCode == 200) {
        print('로그인 성공...');
        final authorizationHeader = response.headers['authorization'];

        if (authorizationHeader != null) {
          final jwtToken = authorizationHeader.replaceFirst('Bearer ', '');
          print('JWT Token: $jwtToken');
          await storage.write(key: 'jwtToken', value: jwtToken);
          _loginStat = true;
          notifyListeners();
          return true;
        } else {
          print('Authorization 헤더가 없습니다.');
        }
      } else if (response.statusCode == 403) {
        print('아이디 또는 비밀번호가 일치하지 않습니다...');
      } else {
        print('네트워크 오류 또는 알 수 없는 오류로 로그인에 실패하였습니다...');
      }
    } on http.ClientException catch (e) {
      print('HTTP Client Exception: $e');
    } on TimeoutException catch (e) {
      print('Timeout Exception: $e');
    } catch (error) {
      print("로그인 실패 $error");
    }

    _loginStat = false;
    notifyListeners();
    return false;
  }

  Future<void> getUserInfo() async {
    final url = 'http://10.0.2.2:8080/users/manage_info';
    try {
      String? token = await storage.read(key: 'jwtToken');
      print('사용자 정보 요청 전: jwt - $token');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: 20));

      if (response.statusCode == 200) {
        var utf8Decoded = utf8.decode(response.bodyBytes);
        var result = json.decode(utf8Decoded);
        final userInfo = result;
        print('User Info: $userInfo');

        _userInfo = User.fromJson(userInfo);
        print(_userInfo);
      } else {
        print('HTTP 요청 실패: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      print('HTTP Client Exception: $e');
    } on TimeoutException catch (e) {
      print('Timeout Exception: $e');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await storage.delete(key: 'jwtToken');
      _userInfo = User();
      _loginStat = false;
      print('로그아웃 성공');
    } catch (error) {
      print('로그아웃 실패');
    }
    notifyListeners();
  }
}
