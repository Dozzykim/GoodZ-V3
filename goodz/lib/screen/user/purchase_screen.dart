import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PurchaseScreen(), // 구매 내역 페이지를 앱의 첫 화면으로 설정
    );
  }
}

class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  // 예시용 구매 내역 데이터
  List<Map<String, dynamic>> purchaseList = [
    {
      'id': 1,
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': '상품 A',
      'price': 30000,
      'orderedAt': '2023-07-22',
    },
    {
      'id': 2,
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': '상품 B',
      'price': 45000,
      'orderedAt': '2023-07-20',
    },
    {
      'id': 3,
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': '상품 C',
      'price': 25000,
      'orderedAt': '2023-07-18',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('구매 내역'),
      ),
      body: ListView.builder(
        itemCount: purchaseList.length,
        itemBuilder: (context, index) {
          final purchase = purchaseList[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(
                purchase['imageUrl'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(purchase['productName']),
              subtitle: Text('가격: ${purchase['price']}원'),
              trailing: Text('주문일: ${purchase['orderedAt']}'),
              // 구매 취소 버튼 추가
              onTap: () {
                _showCancelDialog(purchase); // 구매 취소 다이얼로그 표시
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                // 상품으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login_Screen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                // 유저 정보 화면으로 이동
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => UserProfileScreen()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 구매 취소 다이얼로그 표시 함수
  void _showCancelDialog(Map<String, dynamic> purchase) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('구매 취소'),
          content: Text('정말로 이 구매를 취소하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () {
                _cancelPurchase(purchase); // 구매 취소 처리
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
          ],
        );
      },
    );
  }

  // 구매 취소 처리 함수
  void _cancelPurchase(Map<String, dynamic> purchase) {
    setState(() {
      // purchaseList에서 해당 구매 항목 제거
      purchaseList.removeWhere((item) => item['id'] == purchase['id']);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('구매가 취소되었습니다.'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

// 로그인 화면 예시
class Login_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상품목록'),
      ),
      body: Center(
        child: Text('상품목록'),
      ),
    );
  }
}
