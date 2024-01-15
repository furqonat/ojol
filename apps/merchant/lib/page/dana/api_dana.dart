import 'package:lugo_marchant/response/dana.dart';
import 'package:rest_client/gate_client.dart';
import 'package:rest_client/shared.dart';
import 'package:rest_client/transaction_client.dart';

class ApiDana {
  final GateClient gateClient;
  final TransactionClient trxClient;

  ApiDana({required this.gateClient, required this.trxClient});

  Future<List<DanaProfile>> getDanaProfile({required String token}) async {
    final resp = await gateClient.merchantGetDanaProfile(
      bearerToken: "Bearer $token",
    );
    return (resp as List).map((e) => DanaProfile.fromJson(e)).toList();
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
