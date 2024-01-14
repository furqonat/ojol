import 'package:lugo_marchant/response/commont.dart';
import 'package:lugo_marchant/response/user.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/order_client.dart';
import 'package:rest_client/shared.dart';

class ApiHome {
  final AccountClient accountClient;
  final OrderClient orderClient;

  ApiHome({required this.accountClient, required this.orderClient});

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

  Future<MerchantSellInDay> getMerchantSellInDay(String token) async {
    final resp = await orderClient.merchantGetSell(
      bearerToken: "Bearer $token",
    );
    return MerchantSellInDay.fromJson(resp);
  }

  Future<Response> applyDeviceToke({
    required String token,
    required String deviceToken,
  }) async {
    final resp = await accountClient.merchantAssignDeviceToken(
      bearerToken: "Bearer $token",
      body: DeviceToken(token: deviceToken),
    );
    return resp;
  }
}
