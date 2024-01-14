import 'package:lugo_marchant/response/user.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/shared.dart';

class ApiAccountInfo {
  final AccountClient accountClient;

  ApiAccountInfo({required this.accountClient});

  Future<UserResponse> getUser({required String token}) async {
    final query = QueryBuilder()
      ..addQuery("name", "true")
      ..addQuery("details", "{include: {images:true}}")
      ..addQuery("phone", "true")
      ..addQuery("email", "true")
      ..addQuery("avatar", "true");
    final resp = await accountClient.getMerchant(
      bearerToken: "Bearer $token",
      queries: query.toMap(),
    );
    return UserResponse.fromJson(resp);
  }

  Future<Response> updateUser({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    final resp = await accountClient.updateMerchant(
      bearerToken: "Bearer $token",
      body: body,
    );
    return resp;
  }
}
