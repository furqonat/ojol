import 'dart:convert';

import 'order_detail.dart';

FreeOrder freeOrderFromJson(String str) => FreeOrder.fromJson(json.decode(str));

String freeOrderToJson(FreeOrder data) => json.encode(data.toJson());

class FreeOrder {
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
  OrderDetail? orderDetail;

  FreeOrder({
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
    this.orderDetail,
  });

  factory FreeOrder.fromJson(Map<String, dynamic> json) => FreeOrder(
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
        orderDetail: OrderDetail.fromJson(json["order_detail"]),
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
        "order_detail": orderDetail?.toJson(),
      };
}
