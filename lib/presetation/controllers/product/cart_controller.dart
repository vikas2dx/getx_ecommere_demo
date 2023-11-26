import 'package:get/get.dart';

import '../../../data/model/cart/cart_model.dart';

class CartController extends GetxController {
  RxList<CartModel> cartItems = <CartModel>[].obs;

  int get cartCount => cartItems.length;

  void addToCart(CartModel cartItem) {
    cartItems.add(cartItem);
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
    update();
  }
}
