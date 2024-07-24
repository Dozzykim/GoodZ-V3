import 'package:flutter/material.dart';

class BuyCompleteScreen extends StatelessWidget {
  const BuyCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("주문 완료"),
         centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset("image/logo/Goodz_logo3.png", width: 120, height: 120, fit: BoxFit.fill),
          ),

          SizedBox(height: 90,),

          Center(
            child: Text("주문이 완료되었습니다.", style: TextStyle(fontSize: 26),),
          ),

          SizedBox(height: 30,),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/products');
                },
                child: const Text('상품목록', style: TextStyle(fontSize: 16, color: Colors.black),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 125, 203, 255),
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                ),
              ),
          ),

          SizedBox(height: 10,),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {Navigator.pushNamed(context, '/user/purchase');},
              child: const Text('구매내역', style: TextStyle(fontSize: 16, color: Colors.black),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 175, 175, 175),
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}