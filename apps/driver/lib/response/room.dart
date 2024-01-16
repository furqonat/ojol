import 'dart:convert';

RoomChat roomChatFromJson(String str) => RoomChat.fromJson(json.decode(str));

String roomChatToJson(RoomChat data) => json.encode(data.toJson());

class RoomChat {
  String? id;
  String? customerName;
  String? merchantName;
  String? driverName;
  String? customerId;
  String? merchantId;
  String? driverId;
  bool? status;

  RoomChat({
    this.id,
    this.customerName,
    this.merchantName,
    this.driverName,
    this.customerId,
    this.merchantId,
    this.driverId,
    this.status,
  });

  factory RoomChat.fromJson(Map<String, dynamic> json) => RoomChat(
    id: json["id"],
    customerName: json["customer_name"],
    merchantName: json["merchant_name"],
    driverName: json["driver_name"],
    customerId: json["customer_id"],
    merchantId: json["merchant_id"],
    driverId: json["driver_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_name": customerName,
    "merchant_name": merchantName,
    "driver_name": driverName,
    "customer_id": customerId,
    "merchant_id": merchantId,
    "driver_id": driverId,
    "status": status,
  };
}