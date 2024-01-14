import 'dart:convert';

UserResponse userFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userToJson(UserResponse data) => json.encode(data.toJson());

class DetailImages {
  final String id;
  final String link;

  DetailImages({required this.id, required this.link});

  factory DetailImages.fromJson(Map<String, dynamic> json) {
    return DetailImages(
      id: json['id'],
      link: json['link'],
    );
  }
}

class Detail {
  final String? id;
  final String? name;
  final String? address;
  final String? badge;
  final List<DetailImages>? images;

  Detail({this.id, this.name, this.address, this.images, this.badge});

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      images: json['images'] != null
          ? (json['images'] as List<dynamic>)
              .map((e) => DetailImages.fromJson(e))
              .toList()
          : null,
      badge: json['badge'],
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
  final String? status;
  final dynamic products;

  UserResponse({
    this.avatar,
    this.email,
    this.id,
    this.name,
    this.phone,
    this.detail,
    this.wallet,
    this.status,
    this.products,
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
        status: json['status'],
        products: json['products'],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "email": email,
        "id": id,
        "name": name,
        "phone": phone,
      };
}
