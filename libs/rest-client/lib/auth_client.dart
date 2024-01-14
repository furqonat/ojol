library rest_client;

import 'package:dio/dio.dart' show Dio, RequestOptions, ResponseType, Options;
import 'package:retrofit/retrofit.dart';

part 'auth_client.g.dart';

class AuthResponse {
  final String message;
  final String? token;

  AuthResponse({required this.message, this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(message: json['message'], token: json['token']);
  }
}

class MerchantBody {
  final String type;

  MerchantBody({
    required this.type,
  });

  factory MerchantBody.fromJson(Map<String, dynamic> json) => MerchantBody(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}

@RestApi(baseUrl: "https://auth.gentatechnology.com/")
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @POST("customer")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<AuthResponse> customerSignIn(
      {@Header("Authorization") required String token});

  @POST("driver")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<AuthResponse> driverSignIn(@Header("Authorization") String token);

  @POST("merchant")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<AuthResponse> merchantSignIn({
    @Header("Authorization") required String token,
    @Body() MerchantBody? body,
  });
}
