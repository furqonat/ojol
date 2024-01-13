class CommonResponse {
  final String message;
  final String? res;
  final String? token;

  CommonResponse({required this.message, this.res, this.token});

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      message: json['message'],
      res: json['res'],
    );
  }
}

class MerchantSellInDay {
  final int totalCancel;
  final int totalDone;
  final int totalIncome;

  MerchantSellInDay(
      {required this.totalCancel,
      required this.totalDone,
      required this.totalIncome});

  factory MerchantSellInDay.fromJson(Map<String, dynamic> json) {
    return MerchantSellInDay(
      totalCancel: json['cancel'],
      totalDone: json['done'],
      totalIncome: json['income'],
    );
  }
}
