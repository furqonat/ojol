import 'package:lugo_marchant/response/commont.dart';
import 'package:rest_client/account_client.dart';

class ApiService {
  final AccountClient accountClient;

  ApiService({required this.accountClient});

  Future<CommonResponse> applyMerchant(
      {required Map<String, dynamic> body, required token}) async {
    final resp = await accountClient.applyToBeMerchant(
      bearerToken: "Bearer $token",
      body: body,
    );
    return CommonResponse(message: resp.message, res: resp.res);
  }
}
