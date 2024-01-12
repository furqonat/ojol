import 'package:lugo_marchant/response/user.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';
import 'package:rest_client/account_client.dart';

class ApiHome {
  final AccountClient accountClient;

  ApiHome({required this.accountClient});

  Future<UserResponse> getMerchant(token) async {
    final query = QueryBuilder()
      ..addQuery("name", "true")
      ..addQuery("avatar", "true")
      ..addQuery("details", "true")
      ..addQuery("merchant_wallet", "true")
      ..addQuery("dana_token", "true");
    final resp = await accountClient.getMerchant(
      bearerToken: "Bearer $token",
      queries: query.toMap(),
    );
    return UserResponse.fromJson(resp);
  }
}
