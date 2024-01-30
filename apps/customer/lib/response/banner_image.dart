import 'dart:convert';

BannerImage bannerImageFromJson(String str) => BannerImage.fromJson(json.decode(str));

String bannerImageToJson(BannerImage data) => json.encode(data.toJson());

class BannerImage {
  String? id;
  String? link;
  String? bannerId;

  BannerImage({
    this.id,
    this.link,
    this.bannerId,
  });

  factory BannerImage.fromJson(Map<String, dynamic> json) => BannerImage(
    id: json["id"],
    link: json["link"],
    bannerId: json["banner_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "link": link,
    "banner_id": bannerId,
  };
}