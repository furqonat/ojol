import 'dart:convert';

Count countFromJson(String str) => Count.fromJson(json.decode(str));

String countToJson(Count data) => json.encode(data.toJson());

class Count {
  int? customerProductReview;

  Count({
    this.customerProductReview,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        customerProductReview: json["customer_product_review"],
      );

  Map<String, dynamic> toJson() => {
        "customer_product_review": customerProductReview,
      };
}
