import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final int pNo;
  final String productName;
  final int price;
  final String imgUrl;

  const ProductDetailScreen({
    required this.pNo,
    required this.productName,
    required this.price,
    required this.imgUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
          children: [
            // 👔상품이미지
            Center(
              child: Image.asset(imgUrl, width: 200, height: 200, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            // 🏷상품명
            Text(
              productName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // 💰가격
            Text(
              "${price.toString()} 원",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20), // Spacing before the button
            // 🛒구매하기 버튼
            SizedBox(
              width: double.infinity, // 화면 가로 너비에 맞게 설정
              child: ElevatedButton(
                onPressed: () {
                  // 구매하기 버튼 클릭 시 처리할 로직을 여기에 작성합니다.
                  // 예: Navigator.push(context, MaterialPageRoute(builder: (context) => BuyScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 121, 121, 121), // 버튼 배경색
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 둥근 모서리 반경 설정
                  ),
                ),
                child: const Text(
                  '구매하기',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // 버튼 텍스트 색상을 흰색으로 설정
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
