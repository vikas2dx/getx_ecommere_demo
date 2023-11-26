// cart_listing_screen.dart

import 'package:e_commerce_demo/core/constants/app_strings.dart';
import 'package:e_commerce_demo/presetation/controllers/product/cart_controller.dart';
import 'package:e_commerce_demo/presetation/controllers/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListingScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final ProductsController productController = Get.put(ProductsController());

  CartListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.cartListing),
      ),
      body: Center(
        child: GetBuilder<CartController>(
          builder: (controller) {
            if (controller.cartCount == 0) {
              return const Text(AppStrings.cartEmptyMessage);
            }

            return ListView.builder(
              itemCount: controller.cartCount,
              itemBuilder: (context, index) {
                var cartItem = controller.cartItems[index];
                return ListTile(
                  title: Text(cartItem.productName),
                  subtitle:
                      Text('\$${cartItem.productPrice.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      controller.removeFromCart(index);
                      productController.updateCartRemove(
                          cartItem.productId, controller);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
