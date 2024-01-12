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

class DataResponse {
  final List<dynamic> data;
  final int total;

  DataResponse({required this.data, required this.total});

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    return DataResponse(data: json['data'], total: json['total']);
  }
}
