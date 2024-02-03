import 'dart:convert';

import 'package:lugo_customer/response/product_item.dart';

OrderItem customerFromJson(String str) => OrderItem.fromJson(json.decode(str));

String customerToJson(OrderItem data) => json.encode(data.toJson());

class OrderItem {
  String? id;
  String? productId;
  int? quantity;
  String? orderId;
  ProductItem? product;

  OrderItem({
    this.id,
    this.productId,
    this.quantity,
    this.orderId,
    this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    orderId: json["order_id"],
    product: ProductItem.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "quantity": quantity,
    "order_id": orderId,
    "product": product?.toJson(),
  };
}