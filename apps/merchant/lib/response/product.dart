import 'dart:convert';

import 'count.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  List<dynamic>? category;
  String? description;
  String? id;
  String? image;
  String? name;
  int? price;
  Count? count;

  Product({
    this.category,
    this.description,
    this.id,
    this.image,
    this.name,
    this.price,
    this.count,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        category: List<dynamic>.from(json["category"].map((x) => x)),
        description: json["description"],
        id: json["id"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        count: Count.fromJson(json["_count"]),
      );

  Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category!.map((x) => x)),
        "description": description,
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "_count": count?.toJson(),
      };
}
