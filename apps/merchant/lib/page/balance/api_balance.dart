import 'package:lugo_marchant/response/user.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/gate_client.dart';
import 'package:rest_client/shared.dart';
import 'package:rest_client/transaction_client.dart';

class ApiBalance {
  final AccountClient accountClient;
  final GateClient gateClient;
  final TransactionClient trxClient;

  ApiBalance({
    required this.accountClient,
    required this.gateClient,
    required this.trxClient,
  });

  Future topUp({required String token, required int amount}) async {
    final resp = await gateClient.merchantTopUp(
      bearerToken: "Bearer $token",
      body: {"amount": amount},
    );

    return resp;
  }

  Future withdraw({required String token, required int amount}) async {
    final resp = await gateClient.merchantWithdraw(
      bearerToken: "Bearer $token",
      body: {"amount": amount},
    );

    return resp;
  }

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

  Future<List<Transaction>> getMerchantTransactions({
    required String token,
    trxIn = "day",
  }) async {
    return await trxClient.getMerchantTransactions(
      bearerToken: "Bearer $token",
      queries: {"trxIn": trxIn},
    );
  }
}
