
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

