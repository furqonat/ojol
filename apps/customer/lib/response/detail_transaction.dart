import 'dart:convert';

DetailTransaction detailTransactionFromJson(String str) =>
    DetailTransaction.fromJson(json.decode(str));

String detailTransactionToJson(DetailTransaction data) =>
    json.encode(data.toJson());

class DetailTransaction {
  String? id;
  String? transactionsId;
  String? checkoutUrl;
  String? acquirementId;
  String? merchantTransId;

  DetailTransaction({
    this.id,
    this.transactionsId,
    this.checkoutUrl,
    this.acquirementId,
    this.merchantTransId,
  });

  factory DetailTransaction.fromJson(Map<String, dynamic> json) =>
      DetailTransaction(
        id: json["id"],
        transactionsId: json["transactions_id"],
        checkoutUrl: json["checkout_url"],
        acquirementId: json["acquirement_id"],
        merchantTransId: json["merchant_trans_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transactions_id": transactionsId,
        "checkout_url": checkoutUrl,
        "acquirement_id": acquirementId,
        "merchant_trans_id": merchantTransId,
      };
}
