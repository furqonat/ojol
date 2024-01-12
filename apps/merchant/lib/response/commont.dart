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
