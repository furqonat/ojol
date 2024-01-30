import 'dart:convert';

ImageMerchant imageMerchantFromJson(String str) =>
    ImageMerchant.fromJson(json.decode(str));

String imageMerchantToJson(ImageMerchant data) => json.encode(data.toJson());

class ImageMerchant {
  String? id;
  String? merchantDetailsId;
  String? link;

  ImageMerchant({
    this.id,
    this.merchantDetailsId,
    this.link,
  });

  factory ImageMerchant.fromJson(Map<String, dynamic> json) => ImageMerchant(
        id: json["id"],
        merchantDetailsId: json["merchant_details_id"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "merchant_details_id": merchantDetailsId,
        "link": link,
      };
}
