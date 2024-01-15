class Response {
  final String message;
  final dynamic res;

  Response({
    required this.message,
    required this.res,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        message: json["message"],
        res: json["res"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "res": res,
      };
}

class DataResponse {
  final List<dynamic> data;
  final int total;

  DataResponse({required this.data, required this.total});

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    return DataResponse(data: json['data'], total: json['total']);
  }
}

class Transaction {
  final String id;
  final String trxType;
  final String createdAt;
  final String paymentAt;
  final String status;
  final int amount;

  Transaction({
    required this.id,
    required this.trxType,
    required this.createdAt,
    required this.paymentAt,
    required this.status,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      trxType: json['trx_type'],
      createdAt: json['created_at'],
      paymentAt: json['payment_at'],
      status: json['status'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "trx_type": trxType,
        "created_at": createdAt,
        "payment_at": paymentAt,
        "status": status,
        "amount": amount,
      };
}
