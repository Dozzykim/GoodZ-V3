import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:goodz/home_screen.dart';
import 'package:goodz/provider/user_provider.dart';
import 'package:goodz/screen/products/products_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  late Future<List<dynamic>> _orderList;

  @override
  void initState() {
    super.initState();
    _orderList = fetchOrderHistory();
  }

  // fetchOrderHistory 함수 정의
  Future<List<dynamic>> fetchOrderHistory() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.userInfo?.userId;

    if (userId == null) {
      throw Exception('User not logged in');
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/users/orderHistory?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

   if (response.statusCode == 200) {
    List<dynamic> orderList = json.decode(response.body);
    print('Parsed response: $orderList');
    return orderList;

  } else {
    throw Exception('Failed to load order history');
  }

  }

  // 날짜 문자열을 포맷하는 함수
  String formatDate(String dateStr) {
    // print(dateStr);
    try {
      final DateTime dateTime = DateTime.parse(dateStr);
      final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
      return outputFormat.format(dateTime);
    } catch (e) {
      print('Date format error: $e');
      return dateStr; // 오류 발생 시 원래 문자열 반환
    }
  }

  @override
  Widget build(BuildContext context) {
    String _getImageUrl(int? pno) {
      print('넘어온 상품번호: $pno');
      if (pno == null) {
        return 'image/no-img.jpg'; // 기본 이미지 경로
      }

      switch (pno) {
        case 1:
          return 'image/products/01.jpg';
        case 2:
          return 'image/products/02.jpg';
        case 3:
          return 'image/products/03.jpg';
        case 4:
          return 'image/products/04.jpg';
        default:
          return 'image/no-img.jpg'; // 기본 이미지 경로
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('구매 내역'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _orderList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load order history'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final purchase = snapshot.data![index];
                final pNo = purchase['pno'] as int?;

                // Debugging: Print pNo to check its value and type
                // print('pNo: $pNo');

                final imageUrl = _getImageUrl(pNo);
                final orderedAt = purchase['orderedAt'] as String;

                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            // SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    purchase['productName'],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4.0),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('${purchase['price']}원', style: TextStyle(fontSize: 16),),
                                  ),

                                  SizedBox(height: 5.0),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("${formatDate(orderedAt)}"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        
                        // SizedBox(width: 16.0),
                      ],
                    ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     Text('주문일: ${purchase['orderedAt']}'),
                      //   ],
                      // ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.shopify_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(Map<String, dynamic> purchase) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('구매 취소'),
          content: Text('${purchase['productName']}을(를) 정말로 취소하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('아니요'),
            ),
            TextButton(
              onPressed: () {
                // 여기에 구매 취소 로직 추가
                Navigator.of(context).pop();
              },
              child: Text('예'),
            ),
          ],
        );
      },
    );
  }
}
