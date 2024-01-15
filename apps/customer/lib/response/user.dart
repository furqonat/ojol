import 'dart:convert';

UserResponse userFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  String? avatar;
  String? email;
  String? id;
  String? name;
  String? phone;

  UserResponse({
    this.avatar,
    this.email,
    this.id,
    this.name,
    this.phone,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        avatar: json["avatar"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "email": email,
        "id": id,
        "name": name,
        "phone": phone,
      };
}
