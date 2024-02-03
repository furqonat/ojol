import 'package:lugo_customer/api/api_service.dart';

class ApiDiscount {
  Future<dynamic> getDiscount({required String token}) async {
    var r = await ApiService()
        .apiJSONGetWitFirebaseToken('gate', 'lugo/discount', token);
    return r;
  }
}
