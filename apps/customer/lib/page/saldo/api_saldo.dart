import 'package:lugo_customer/api/api_service.dart';

class ApiSaldo {
  Future<dynamic> getSaldoDana({required String token}) async =>
      await ApiService().apiJSONGetWitFirebaseToken('gate', 'oauth/profile', token);

  Future<dynamic> getOauth({required String token}) async =>
      await ApiService().apiJSONGetWitFirebaseToken('gate', 'oauth', token);
}
