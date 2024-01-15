import 'dart:convert';
import 'package:lugo_customer/response/merchant_product.dart';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  String? id;
  int? quantity;
  String? productId;
  String? cartId;
  MerchantProduct? product;

  Cart({
    this.id,
    this.quantity,
    this.productId,
    this.cartId,
    this.product,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        quantity: json["quantity"],
        productId: json["product_id"],
        cartId: json["cart_id"],
        product: MerchantProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product_id": productId,
        "cart_id": cartId,
        "product": product?.toJson(),
      };
}
