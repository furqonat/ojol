import 'dart:convert';
import 'package:lugo_customer/response/detail_transaction.dart';

Transactions transactionFromJson(String str) =>
    Transactions.fromJson(json.decode(str));

String transactionToJson(Transactions data) => json.encode(data.toJson());

class Transactions {
  DetailTransaction? detail;
  String? message;
  String? res;

  Transactions({
    this.detail,
    this.message,
    this.res,
  });

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        detail: DetailTransaction.fromJson(json["detail"]),
        message: json["message"],
        res: json["res"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail?.toJson(),
        "message": message,
        "res": res,
      };
}
