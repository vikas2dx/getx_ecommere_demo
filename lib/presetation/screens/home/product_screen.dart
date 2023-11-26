import 'package:e_commerce_demo/core/constants/app_strings.dart';
import 'package:e_commerce_demo/presetation/controllers/product/cart_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/product/product_controller.dart';
import '../cart/cart_listing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductsController _productController = Get.put(ProductsController());
  final CartController _cartController = Get.put(CartController());

  @override
  void initState() {
    _productController.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.productList),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => CartListingScreen());
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Obx(() => Text(
                      _cartController.cartCount.toString(),
                      style: const TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ],
      ),
      body: Obx(
        () => _productController.products.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _productController.products.length,
                itemBuilder: (context, index) {
                  final product = _productController.products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                      '\$${product.price.toStringAsFixed(2)} | Quantity: ${product.quantity}',
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Add the product to the cart
                        _productController.addToCart(product, _cartController);
                      },
                      child: const Text('Add to Cart'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
