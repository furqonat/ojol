import 'dart:convert';

Favorite favoriteFromJson(String str) => Favorite.fromJson(json.decode(str));

String favoriteToJson(Favorite data) => json.encode(data.toJson());

class Favorite {
  String? customerId;

  Favorite({
    this.customerId,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    customerId: json["customer_id"],
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
  };
}