class CartModel {
  final String productId;
  final String productName;
  final double productPrice;
  int quantity;

  CartModel({
    required this.productId,
    required this.productName,
    required this.productPrice,
    this.quantity = 1,
  });
}
