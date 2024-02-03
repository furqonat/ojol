import 'dart:convert';

ProductItem productItemFromJson(String str) => ProductItem.fromJson(json.decode(str));

String productItemToJson(ProductItem data) => json.encode(data.toJson());

class ProductItem {
  String? id;
  String? merchantId;
  String? name;
  String? image;
  String? description;
  int? price;
  String? productType;
  bool? status;

  ProductItem({
    this.id,
    this.merchantId,
    this.name,
    this.image,
    this.description,
    this.price,
    this.productType,
    this.status,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
    id: json["id"],
    merchantId: json["merchant_id"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    price: json["price"],
    productType: json["product_type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_id": merchantId,
    "name": name,
    "image": image,
    "description": description,
    "price": price,
    "product_type": productType,
    "status": status,
  };
}