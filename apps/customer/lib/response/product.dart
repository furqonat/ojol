import 'dart:convert';
import 'count.dart';
import 'favorite.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String? description;
  List<Favorite>? favorites;
  String? id;
  String? image;
  String? name;
  int? price;
  Count? count;

  Product({
    this.description,
    this.favorites,
    this.id,
    this.image,
    this.name,
    this.price,
    this.count,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        description: json["description"],
        favorites: List<Favorite>.from(
            json["favorites"].map((x) => Favorite.fromJson(x))),
        id: json["id"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        count: Count.fromJson(json["_count"]),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "favorites": List<dynamic>.from(favorites!.map((x) => x.toJson())),
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "_count": count?.toJson(),
      };
}
