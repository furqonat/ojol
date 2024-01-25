import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomChat {
  String? id;
  String? customerId;
  String? merchantId;
  String? driverId;
  bool? status;
  DateTime? dateTime;

  RoomChat({
    this.id,
    this.customerId,
    this.merchantId,
    this.driverId,
    this.status,
    this.dateTime,
  });

  factory RoomChat.fromJson(Map<String, dynamic> json) => RoomChat(
    id: json["id"],
    customerId: json["customer_id"],
    merchantId: json["merchant_id"],
    driverId: json["driver_id"],
    status: json["status"],
    dateTime: (json["datetime"] as Timestamp?)?.toDate(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "merchant_id": merchantId,
    "driver_id": driverId,
    "status": status,
    "datetime": dateTime != null ? Timestamp.fromDate(dateTime!) : null,
  };
}
