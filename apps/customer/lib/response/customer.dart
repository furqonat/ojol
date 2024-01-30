import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  String? id;
  String? name;
  String? email;
  DateTime? createdAt;
  bool? emailVerified;
  bool? phoneVerified;
  String? avatar;
  String? status;

  Customer({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.emailVerified,
    this.phoneVerified,
    this.avatar,
    this.status,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    createdAt: DateTime.parse(json["created_at"]),
    emailVerified: json["email_verified"],
    phoneVerified: json["phone_verified"],
    avatar: json["avatar"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "created_at": createdAt?.toIso8601String(),
    "email_verified": emailVerified,
    "phone_verified": phoneVerified,
    "avatar": avatar,
    "status": status,
  };
}