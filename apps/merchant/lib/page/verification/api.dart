import 'package:lugo_marchant/response/commont.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/shared.dart';

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

  Future<Response> verifyPhone({required String phoneNumber, required String token}) async {
    final resp = await accountClient.merchantVerifyPhoneNumber(
      bearerToken: "Bearer $token",
      body: Verification(phoneNumber: phoneNumber),
    );
    return resp;
  }

  Future<Response> verifyOTP({
    required String otp,
    required String token,
    required String verificationId,
  }) async {
    final resp = await accountClient.merchantFinishVerifyPhoneNumber(
      bearerToken: "Bearer $token",
      id: verificationId,
      body: VerifyPhoneNumber(smsCode: otp),
    );
    return resp;
  }
}
