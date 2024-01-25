class Amount {
  final String currency;
  final String value;

  Amount({required this.currency, required this.value});

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
      currency: json['currency'],
      value: json['value'],
    );
  }
}

class DanaProfile {
  final String? resourceType;
  final Amount? value;

  DanaProfile({this.resourceType, this.value});

  factory DanaProfile.fromJson(Map<String, dynamic> json) {
    return DanaProfile(
      resourceType: json['balanceType'],
      value: json['amount'] != null ? Amount.fromJson(json['amount']) : null,
    );
  }
}
