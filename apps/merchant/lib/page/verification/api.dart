import 'package:lugo_marchant/api/api_service.dart' as service;
import 'package:lugo_marchant/response/commont.dart';

class ApiService {
  final apiService = service.ApiService();
  Future<CommonResponse> applyMerchant(
      {required Map<String, dynamic> body, required token}) async {
    final resp = await apiService.apiJSONPostWithFirebaseToken(
      "account",
      "merchant",
      body,
      token,
    );
    return CommonResponse.fromJson(resp);
  }
}
