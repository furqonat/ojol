import 'dart:convert';

MerchantProduct merchantProductFromJson(String str) =>
    MerchantProduct.fromJson(json.decode(str));

String merchantProductToJson(MerchantProduct data) =>
    json.encode(data.toJson());

class MerchantProduct {
  String? id;
  String? merchantId;
  String? name;
  String? image;
  String? description;
  int? price;
  String? productType;
  bool? status;

  MerchantProduct({
    this.id,
    this.merchantId,
    this.name,
    this.image,
    this.description,
    this.price,
    this.productType,
    this.status,
  });

  factory MerchantProduct.fromJson(Map<String, dynamic> json) =>
      MerchantProduct(
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
