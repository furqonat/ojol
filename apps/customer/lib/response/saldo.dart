import 'dart:convert';

Saldo saldoFromJson(String str) => Saldo.fromJson(json.decode(str));

String saldoToJson(Saldo data) => json.encode(data.toJson());

class Saldo {
  String? value;
  String? currency;

  Saldo({
    this.value,
    this.currency,
  });

  factory Saldo.fromJson(Map<String, dynamic> json) => Saldo(
    value: json["value"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "currency": currency,
  };
}