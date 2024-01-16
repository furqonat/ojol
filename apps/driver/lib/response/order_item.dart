// To parse this JSON data, do
//
//     final orderItem = orderItemFromJson(jsonString);

import 'dart:convert';

OrderItem orderItemFromJson(String str) => OrderItem.fromJson(json.decode(str));

String orderItemToJson(OrderItem data) => json.encode(data.toJson());

class OrderItem {
  String? id;
  String? productId;
  int? quantity;
  String? orderId;

  OrderItem({
    this.id,
    this.productId,
    this.quantity,
    this.orderId,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "quantity": quantity,
    "order_id": orderId,
  };
}
