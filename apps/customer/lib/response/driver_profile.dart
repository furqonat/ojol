import 'dart:convert';
import 'package:lugo_customer/response/driver_info.dart';

DriverProfile driverProfileFromJson(String str) => DriverProfile.fromJson(json.decode(str));

String driverProfileToJson(DriverProfile data) => json.encode(data.toJson());

class DriverProfile {
  String? id;
  String? name;
  String? email;
  String? avatar;
  DriverInfo? driverDetails;

  DriverProfile({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.driverDetails,
  });

  factory DriverProfile.fromJson(Map<String, dynamic> json) => DriverProfile(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    avatar: json["avtar"],
    driverDetails: DriverInfo.fromJson(json["driver_details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatar": email,
    "driver_details": driverDetails?.toJson(),
  };
}