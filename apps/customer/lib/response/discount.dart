import 'dart:convert';

Discount discountFromJson(String str) => Discount.fromJson(json.decode(str));

String discountToJson(Discount data) => json.encode(data.toJson());

class Discount {
  String? id;
  String? code;
  DateTime? expiredAt;
  bool? status;
  DateTime? createdAt;
  int? maxDiscount;
  int? amount;
  String? trxType;
  int? minTransaction;

  Discount({
    this.id,
    this.code,
    this.expiredAt,
    this.status,
    this.createdAt,
    this.maxDiscount,
    this.amount,
    this.trxType,
    this.minTransaction,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json["id"],
        code: json["code"],
        expiredAt: DateTime.parse(json["expired_at"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        maxDiscount: json["max_discount"],
        amount: json["amount"],
        trxType: json["trx_type"],
        minTransaction: json["min_transaction"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "expired_at": expiredAt?.toIso8601String(),
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "max_discount": maxDiscount,
        "amount": amount,
        "trx_type": trxType,
        "min_transaction": minTransaction,
      };
}
