import 'dart:convert';

OrderDetail orderDetailFromJson(String str) => OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  String? id;
  String? orderId;
  double? latitude;
  double? longitude;
  String? address;
  double? dstLatitude;
  double? dstLongitude;
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
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    address: json["address"],
    dstLatitude: json["dst_latitude"].toDouble(),
    dstLongitude: json["dst_longitude"].toDouble(),
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