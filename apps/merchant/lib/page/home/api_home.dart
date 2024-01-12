import 'package:lugo_marchant/api/api_service.dart';
import 'package:lugo_marchant/response/user.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';

class ApiHome {
  final service = ApiService();

  Future<UserResponse> getMerchant(token) async {
    final query = QueryBuilder("merchant")
      ..addQuery("name", "true")
      ..addQuery("avatar", "true")
      ..addQuery("details", "true")
      ..addQuery("merchant_wallet", "true")
      ..addQuery("dana_token", "true");
    final resp = await service.apiJSONGetWitFirebaseToken(
        "account", query.build().toString(), token);
    return UserResponse.fromJson(resp);
  }
}
