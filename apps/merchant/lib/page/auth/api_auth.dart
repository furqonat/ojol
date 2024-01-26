import 'dart:developer';

import 'package:lugo_marchant/page/auth/response.dart';
import 'package:lugo_marchant/response/user.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/auth_client.dart';

class ApiAuth {
  final AuthClient authClient;
  final AccountClient accountClient;

  ApiAuth({required this.authClient, required this.accountClient});
  Future<AuthClaims> claimToken({
    required String token,
    required String? type,
  }) async {
    log("sign up type $type");
    final resp = await authClient.merchantSignIn(
      token: "Bearer $token",
      body: MerchantBody(type: "$type"),
    );
    return AuthClaims(message: resp.message, token: resp.token);
  }

  Future<UserResponse> getCurrentUser(String token) async {
    final query = QueryBuilder()
      ..addQuery("id", "true")
      ..addQuery("details", "true");
    final resp = await accountClient.getMerchant(
      bearerToken: "Bearer $token",
      queries: query.toMap(),
    );
    return UserResponse.fromJson(resp);
  }
}
