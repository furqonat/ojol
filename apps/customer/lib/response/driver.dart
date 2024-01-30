import 'dart:convert';

Driver driverFromJson(String str) => Driver.fromJson(json.decode(str));

String driverToJson(Driver data) => json.encode(data.toJson());

class Driver {
  String? address;
  String? id;
  bool? isOnline;
  double? latitude;
  double? longitude;
  String? name;
  String? type;

  Driver({
    this.address,
    this.id,
    this.isOnline,
    this.latitude,
    this.longitude,
    this.name,
    this.type,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        address: json["address"],
        id: json["id"],
        isOnline: json["isOnline"],
        latitude: json["latitude"] ?? 0.0,
        longitude: json["longitude"] ?? 0.0,
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "id": id,
        "isOnline": isOnline,
        "latitude": latitude,
        "longitude": longitude,
        "name": name,
        "type": type,
      };
}
