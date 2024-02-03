import 'dart:convert';

import 'package:lugo_customer/response/driver_vehicle.dart';

DriverInfo driverInfoFromJson(String str) => DriverInfo.fromJson(json.decode(str));

String driverInfoToJson(DriverInfo data) => json.encode(data.toJson());

class DriverInfo {
  String? id;
  String? address;
  String? driverId;
  String? licenseImage;
  String? idCardImage;
  dynamic currentLat;
  dynamic currentLng;
  String? badge;
  String? driverType;
  DriverVehicle? vehicle;

  DriverInfo({
    this.id,
    this.address,
    this.driverId,
    this.licenseImage,
    this.idCardImage,
    this.currentLat,
    this.currentLng,
    this.badge,
    this.driverType,
    this.vehicle,
  });

  factory DriverInfo.fromJson(Map<String, dynamic> json) => DriverInfo(
    id: json["id"],
    address: json["address"],
    driverId: json["driver_id"],
    licenseImage: json["license_image"],
    idCardImage: json["id_card_image"],
    currentLat: json["current_lat"],
    currentLng: json["current_lng"],
    badge: json["badge"],
    driverType: json["driver_type"],
    vehicle: json["vehicle"] != null ? DriverVehicle.fromJson(json["vehicle"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "driver_id": driverId,
    "license_image": licenseImage,
    "id_card_image": idCardImage,
    "current_lat": currentLat,
    "current_lng": currentLng,
    "badge": badge,
    "driver_type": driverType,
    "vehicle": vehicle?.toJson(),
  };
}