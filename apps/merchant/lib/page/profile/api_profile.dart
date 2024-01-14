import 'package:lugo_marchant/response/user.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/shared.dart';

class ApiProfile {
  final AccountClient accountClient;

  ApiProfile({required this.accountClient});

  Future<UserResponse> userDetail({required String token}) async {
    final query = QueryBuilder()
      ..addQuery("id", "true")
      ..addQuery("details", "true")
      ..addQuery("avatar", "true")
      ..addQuery("status", "true")
      ..addQuery("email", "true");

    var r = await accountClient.getMerchant(
      bearerToken: "Bearer $token",
      queries: query.toMap(),
    );

    return UserResponse.fromJson(r);
  }

  Future<Response> updateMerchantOpen({
    required String token,
    required bool status,
  }) async {
    final body = {
      "is_open": status,
    };
    return await accountClient.updateMerchant(
      bearerToken: "Bearer $token",
      body: body,
    );
  }
}
