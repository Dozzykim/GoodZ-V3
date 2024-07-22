import 'package:flutter/material.dart';
import 'package:goodz/models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  // 상품 세팅
  List<Product> productList = [
    Product(
      pNo: 1,
      productName: "Stussy Cherries T-Shirt Berry",
      price: 150000
    ),
    Product(
      pNo: 2,
      productName: "IAB Studio T-Shirt Green Pink",
      price: 80000
    ),
    Product(
      pNo: 3,
      productName: "Nike Dri-Fit Park 7 T-Shirt Volt",
      price: 35000
    ),
    Product(
      pNo: 4,
      productName: "Matin Kim Logo Coating Jumper Pink",
      price: 123000
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("상품 목록"),
        centerTitle: true
      ),
      body: GridView.builder(
        itemCount: productList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.9,
          crossAxisCount: 2
        ),
        itemBuilder: (context, index) {
          return productContainer(
            pNo: productList[index].pNo ?? 0,
            productName: productList[index].productName ?? "",
            price: productList[index].price ?? 0
          );
          // ⭐⭐⭐⭐⭐⭐
        }
      )
    );
  }

  Widget productContainer({required int pNo, required String productName, required int price}) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          // 이미지 관련
        ],
      ),
    );
  }
}