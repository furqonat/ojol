import 'dart:convert';
import 'package:lugo_customer/response/merchant_detail.dart';

Merchant merchantFromJson(String str) => Merchant.fromJson(json.decode(str));

String merchantToJson(Merchant data) => json.encode(data.toJson());

class Merchant {
  String? id;
  MerchantDetail? details;

  Merchant({
    this.id,
    this.details,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        id: json["id"],
        details: MerchantDetail.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "details": details?.toJson(),
      };
}
