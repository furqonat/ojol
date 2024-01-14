class Product {
  final String name;
  final String description;
  final String image;
  final int price;
  final String productType;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.productType,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "image": image,
      "price": price,
      "product_type": productType,
    };
  }
}
