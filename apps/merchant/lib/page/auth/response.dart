class AuthClaims {
  final String? message;
  final String? token;

  AuthClaims({this.message, this.token});

  factory AuthClaims.fromJson(Map<String, dynamic> json) {
    return AuthClaims(
      message: json['message'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    return data;
  }
}
