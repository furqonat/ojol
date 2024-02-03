import 'dart:convert';

import 'package:lugo_customer/response/image_merchant.dart';

MerchantDetail merchantDetailFromJson(String str) =>
    MerchantDetail.fromJson(json.decode(str));

String merchantDetailToJson(MerchantDetail data) => json.encode(data.toJson());

class MerchantDetail {
  String? address;
  String? name;
  List<ImageMerchant>? images;

  MerchantDetail({
    this.address,
    this.name,
    this.images,
  });

  factory MerchantDetail.fromJson(Map<String, dynamic> json) => MerchantDetail(
        address: json["address"],
        name: json["name"],
        images: List<ImageMerchant>.from(
            json["images"].map((x) => ImageMerchant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "name": name,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}
