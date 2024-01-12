import 'dart:convert';

UserResponse userFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userToJson(UserResponse data) => json.encode(data.toJson());

class Detail {
  final String? id;
  final String? name;

  Detail({this.id, this.name});

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Wallet {
  final int balance;

  Wallet({required this.balance});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(balance: json['balance']);
  }
}

class UserResponse {
  final String? avatar;
  final String? email;
  final String? id;
  final String? name;
  final String? phone;
  final Detail? detail;
  final Wallet? wallet;

  UserResponse({
    this.avatar,
    this.email,
    this.id,
    this.name,
    this.phone,
    this.detail,
    this.wallet,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        avatar: json["avatar"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        detail:
            json['details'] != null ? Detail.fromJson(json['details']) : null,
        wallet: json['merchant_wallet'] != null
            ? Wallet.fromJson(json['merchant_wallet'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "email": email,
        "id": id,
        "name": name,
        "phone": phone,
      };
}
