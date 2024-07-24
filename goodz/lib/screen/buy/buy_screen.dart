import 'package:flutter/material.dart';
import 'package:goodz/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:goodz/screen/buy/buy_complete_screen.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class BuyScreen extends StatelessWidget {
  final int pNo;
  final String productName;
  final int price;
  final String imgUrl;

  const BuyScreen({
    required this.pNo,
    required this.productName,
    required this.price,
    required this.imgUrl,
    super.key,
  });

  Future<void> _placeOrder(BuildContext context, String userId) async {
    final url = 'http://10.0.2.2:8080/buy'; // 서버의 API URL로 변경하세요

    final order = {
      'userId': userId,
      'pno': pNo,
      'productName': productName,
      'price': price,
    };

    print('order 객체정보: $order');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(order),
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody == 'SUCCESS') {
          // 주문 성공 시 BuyCompleteScreen으로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuyCompleteScreen()),
          );
        } else {
          // 주문 실패 시 처리 (예: 오류 메시지 표시)
          _showErrorDialog(context, '주문 처리 실패');
        }
      } else {
        // 서버 오류 처리
        _showErrorDialog(context, '서버 오류 발생');
      }
    } catch (e) {
      // 네트워크 오류 처리
      _showErrorDialog(context, '네트워크 오류 발생');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('오류'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.userInfo?.userId;

    if (userId == null) {
      return Scaffold(
        body: Center(child: Text('로그인 정보가 없습니다.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("구매하기"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상품 이미지
                Image.asset(imgUrl, width: 120, height: 120, fit: BoxFit.cover),
                const SizedBox(width: 20),
                // 상품명+가격
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("상품명", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(productName, style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 10),
                      Text("${price.toString()} 원", style: TextStyle(fontSize: 20)),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // 최종 주문정보 섹션에 바탕색 주기
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromARGB(106, 209, 209, 209), // 배경색
                borderRadius: BorderRadius.circular(8), // 모서리 둥글기
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("최종 주문정보", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("구매가", style: TextStyle(fontSize: 16)),
                      Text("${price.toString()} 원", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("배송비", style: TextStyle(fontSize: 16)),
                      Text("무료배송", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("할인", style: TextStyle(fontSize: 16)),
                      Text("0원", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // 총 결제금액과 금액을 나란히 배치하기 위한 Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("총 결제금액", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("${price.toString()} 원", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                ),
              ],
            ),

            Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _placeOrder(context, userId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 90, 167, 255),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '구매하기',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
