import 'dart:convert';

import 'driver_detail.dart';

UserResponse userFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  String? avatar;
  String? email;
  String? id;
  String? name;
  String? phone;
  DriverDetail? driverDetail;

  UserResponse({
    this.avatar,
    this.email,
    this.id,
    this.name,
    this.phone,
    this.driverDetail
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
      avatar: json["avatar"],
      email: json["email"],
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      driverDetail: json["driver_details"] != null ? DriverDetail.fromJson(json["driver_details"]) : null
      );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "email": email,
    "id": id,
    "name": name,
    "phone": phone,
    "driver_details": driverDetail?.toJson()
      };
}
