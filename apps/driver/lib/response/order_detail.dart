// To parse this JSON data, do
//
//     final orderDetail = orderDetailFromJson(jsonString);

import 'dart:convert';

OrderDetail orderDetailFromJson(String str) => OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  String? id;
  String? orderId;
  int? latitude;
  int? longitude;
  String? address;
  int? dstLatitude;
  int? dstLongitude;
  String? dstAddress;

  OrderDetail({
    this.id,
    this.orderId,
    this.latitude,
    this.longitude,
    this.address,
    this.dstLatitude,
    this.dstLongitude,
    this.dstAddress,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    orderId: json["order_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    dstLatitude: json["dst_latitude"],
    dstLongitude: json["dst_longitude"],
    dstAddress: json["dst_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "dst_latitude": dstLatitude,
    "dst_longitude": dstLongitude,
    "dst_address": dstAddress,
  };
}
