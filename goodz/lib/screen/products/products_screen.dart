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
        price: 150000,
        imgUrl: 'image/products/01.jpg'),
    Product(
        pNo: 2,
        productName: "IAB Studio T-Shirt Green Pink",
        price: 80000,
        imgUrl: 'image/products/02.jpg'),
    Product(
        pNo: 3,
        productName: "Nike Dri-Fit Park 7 T-Shirt Volt",
        price: 35000,
        imgUrl: 'image/products/03.jpg'),
    Product(
        pNo: 4,
        productName: "Matin Kim Logo Coating Jumper Pink",
        price: 123000,
        imgUrl: 'image/products/04.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("상품 목록"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final product = productList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/products/detail',
                      arguments: {
                        'pNo': product.pNo,
                        'productName': product.productName,
                        'price': product.price,
                        'imgUrl': product.imgUrl,
                      },
                    );
                  },
                  child: productContainer(
                    pNo: product.pNo ?? 0,
                    productName: product.productName ?? "-",
                    price: product.price ?? 0,
                    imgUrl: product.imgUrl ?? "-",
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: const Text('Home'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/user/purchase');
            },
            child: const Text('마이페이지'),
          ),
          const SizedBox(height: 16), // Add some space below the button
        ],
      ),
    );
  }

  Widget productContainer(
      {required int pNo,
      required String productName,
      required int price,
      required String imgUrl}) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 15), // Increased vertical padding
      color: const Color.fromARGB(111, 199, 199, 199),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the left
        children: [
          Image.asset(imgUrl, width: 130, height: 130, fit: BoxFit.cover),
          const SizedBox(height: 10),
          Text(productName,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8), // Spacing between product name and price
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 0, vertical: 0), // Padding above the price
            child: Text(
              "${price.toString()} 원",
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight:
                      FontWeight.bold), // Adjust fontSize or weight if needed
            ),
          ),
        ],
      ),
    );
  }
}
