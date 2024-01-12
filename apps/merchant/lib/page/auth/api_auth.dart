import 'package:lugo_marchant/page/auth/response.dart';
import 'package:lugo_marchant/response/user.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';

import '../../api/api_service.dart';

class ApiAuth {
  Future<AuthClaims> claimToken({
    required String token,
    required Map<String, dynamic>? body,
  }) async {
    final resp = await ApiService()
        .apiJSONPostWithFirebaseToken('auth', 'merchant', body, token);
    return AuthClaims.fromJson(resp);
  }

  Future<UserResponse> getCurrentUser(String token) async {
    final query = QueryBuilder("merchant")
      ..addQuery("id", "true")
      ..addQuery("details", "true");
    final resp = await ApiService()
        .apiJSONGetWitFirebaseToken("account", query.build().toString(), token);
    return UserResponse.fromJson(resp);
  }
}
