class Product {
  final String id;
  final String name;
  final double price;
  int quantity;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      this.quantity = 1});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      quantity: json['quantity'] ?? 1,
    );
  }
}
