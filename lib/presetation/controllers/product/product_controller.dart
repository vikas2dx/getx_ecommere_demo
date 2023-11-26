// products_controller.dart
import 'dart:convert';

import 'package:e_commerce_demo/presetation/controllers/product/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/model/cart/cart_model.dart';
import '../../../data/model/product/product_model.dart';

class ProductsController extends GetxController {
  final RxList<Product> products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      List<Product> productList = await getProducts();
      products.assignAll(productList);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<List<Product>> getProducts() async {
    String data = await rootBundle.loadString('assets/json/products.json');
    List<dynamic> jsonList = json.decode(data);

    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  void addToCart(Product product, CartController cartController) {
    // Check if the product is in the cart
    int existingIndex = products.indexWhere((item) => item.id == product.id);

    // If the product is in the cart, reduce its quantity
    // Ensure the quantity does not go below 0
    if (products[existingIndex].quantity != 0) {
      products[existingIndex].quantity--;

      // add the product to the cart
      cartController.addToCart(CartModel(
        productId: product.id,
        productName: product.name,
        productPrice: product.price,
      ));
    } else {
      Get.snackbar(
        'Cart Add Failed',
        'You have 0 Item Left in Cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    products.refresh();
    update();
  }

  void updateCartRemove(String id, CartController cartController) {
    int existingIndex = products.indexWhere((item) => item.id == id);
    products[existingIndex].quantity++;
    products.refresh();
    update();
  }
}
