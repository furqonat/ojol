import 'dart:convert';

DriverDetail driverDetailFromJson(String str) => DriverDetail.fromJson(json.decode(str));

String driverDetailToJson(DriverDetail data) => json.encode(data.toJson());

class DriverDetail {
  String? id;
  String? address;
  String? driverId;
  String? licenseImage;
  String? idCardImage;
  double? currentLat;
  double? currentLng;
  String? badge;
  String? driverType;

  DriverDetail({
    this.id,
    this.address,
    this.driverId,
    this.licenseImage,
    this.idCardImage,
    this.currentLat,
    this.currentLng,
    this.badge,
    this.driverType,
  });

  factory DriverDetail.fromJson(Map<String, dynamic> json) => DriverDetail(
    id: json["id"],
    address: json["address"],
    driverId: json["driver_id"],
    licenseImage: json["license_image"],
    idCardImage: json["id_card_image"],
    currentLat: json["current_lat"].toDouble(),
    currentLng: json["current_lng"].toDouble(),
    badge: json["badge"],
    driverType: json["driver_type"],
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
  };
}
