import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

LiveTransaction liveTransactionFromJson(String str) =>
    LiveTransaction.fromJson(json.decode(str));

String liveTransactionToJson(LiveTransaction data) =>
    json.encode(data.toJson());

class LiveTransaction {
  DateTime? createdAt;
  String? customerId;
  dynamic driverId;
  dynamic endedAt;
  String? id;
  String? orderType;
  dynamic paymentAt;
  String? paymentType;
  String? status;

  LiveTransaction({
    this.createdAt,
    this.customerId,
    this.driverId,
    this.endedAt,
    this.id,
    this.orderType,
    this.paymentAt,
    this.paymentType,
    this.status,
  });

  factory LiveTransaction.fromJson(Map<String, dynamic> json) =>
      LiveTransaction(
        createdAt: json["created_at"] != null
            ? (json["created_at"]   as Timestamp).toDate()
            : null,
        customerId: json["customer_id"],
        driverId: json["driver_id"],
        endedAt: json["ended_at"],
        id: json["id"],
        orderType: json["order_type"],
        paymentAt: json["payment_at"],
        paymentType: json["payment_type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt != null ? Timestamp.fromDate(createdAt!) : null,
        "customer_id": customerId,
        "driver_id": driverId,
        "ended_at": endedAt,
        "id": id,
        "order_type": orderType,
        "payment_at": paymentAt,
        "payment_type": paymentType,
        "status": status,
      };
}
