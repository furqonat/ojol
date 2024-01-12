import 'package:lugo_marchant/response/user.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';
import 'package:rest_client/account_client.dart';

class ApiProfile {
  final AccountClient accountClient;

  ApiProfile({required this.accountClient});

  Future<UserResponse> userDetail({required String token}) async {
    final query = QueryBuilder()
      ..addQuery("id", "true")
      ..addQuery("details", "true")
      ..addQuery("avatar", "true")
      ..addQuery("email", "true");

    var r = await accountClient.getMerchant(
      bearerToken: "Bearer $token",
      queries: query.toMap(),
    );

    return UserResponse.fromJson(r);
  }
}
