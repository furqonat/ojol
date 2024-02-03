import 'dart:convert';

import 'package:lugo_customer/response/banner_image.dart';

Banners bannerFromJson(String str) => Banners.fromJson(json.decode(str));

String bannerToJson(Banners data) => json.encode(data.toJson());

class Banners {
  String? id;
  String? position;
  dynamic url;
  dynamic description;
  bool? status;
  bool? forApp;
  List<BannerImage>? images;

  Banners({
    this.id,
    this.position,
    this.url,
    this.description,
    this.status,
    this.forApp,
    this.images,
  });

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
    id: json["id"],
    position: json["position"],
    url: json["url"],
    description: json["description"],
    status: json["status"],
    forApp: json["for_app"],
    images: json["images"] != null
        ? List<BannerImage>.from(json["images"].map((x) => BannerImage.fromJson(x)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "position": position,
    "url": url,
    "description": description,
    "status": status,
    "for_app": forApp,
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}