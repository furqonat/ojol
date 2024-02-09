import 'dart:convert';

import 'package:lugo_driver/response/user.dart';

import 'order_detail.dart';
import 'order_item.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  String? id;
  String? orderType;
  String? orderStatus;
  String? paymentType;
  DateTime? createdAt;
  String? customerId;
  int? grossAmount;
  int? netAmount;
  int? totalAmount;
  int? shippingCost;
  int? weightCost;
  int? version;
  bool? showable;
  List<OrderItem>? orderItems;
  OrderDetail? orderDetail;
  UserResponse? customer;

  Order({
    this.id,
    this.orderType,
    this.orderStatus,
    this.paymentType,
    this.createdAt,
    this.customerId,
    this.grossAmount,
    this.netAmount,
    this.totalAmount,
    this.shippingCost,
    this.weightCost,
    this.version,
    this.showable,
    this.orderItems,
    this.orderDetail,
    this.customer,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderType: json["order_type"],
        orderStatus: json["order_status"],
        paymentType: json["payment_type"],
        createdAt: DateTime.parse(json["created_at"]),
        customerId: json["customer_id"],
        grossAmount: json["gross_amount"],
        netAmount: json["net_amount"],
        totalAmount: json["total_amount"],
        shippingCost: json["shipping_cost"],
        weightCost: json["weight_cost"],
        version: json["version"],
        showable: json["showable"],
        orderItems: json["order_items"] != null ? List<OrderItem>.from(json["order_items"].map((x) => OrderItem.fromJson(x))) : null,
        orderDetail: OrderDetail.fromJson(json["order_detail"]),
        customer: UserResponse.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_type": orderType,
        "order_status": orderStatus,
        "payment_type": paymentType,
        "created_at": createdAt?.toIso8601String(),
        "customer_id": customerId,
        "gross_amount": grossAmount,
        "net_amount": netAmount,
        "total_amount": totalAmount,
        "shipping_cost": shippingCost,
        "weight_cost": weightCost,
        "version": version,
        "showable": showable,
        "order_items": orderItems != null ? List<dynamic>.from(orderItems!.map((x) => x.toJson())) : null,
        "order_detail": orderDetail?.toJson(),
        "customer": customer?.toJson(),
      };
}
