import 'dart:convert';

Riders ridersFromJson(String str) => Riders.fromJson(json.decode(str));

String ridersToJson(Riders data) => json.encode(data.toJson());

class Riders {
  String? id;
  String? address;
  bool? isOnline;
  dynamic latitude;
  dynamic longitude;
  String? name;
  String? type;

  Riders({
    this.id,
    this.address,
    this.isOnline,
    this.latitude,
    this.longitude,
    this.name,
    this.type,
  });

  factory Riders.fromJson(Map<String, dynamic> json) => Riders(
    id: json["id"],
    address: json["address"],
    isOnline: json["isOnline"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "isOnline": isOnline,
    "latitude": latitude,
    "longitude": longitude,
    "name": name,
    "type": type,
  };
}