import 'package:lugo_customer/api/api_service.dart';

class ApiProfile {
  Future<dynamic> userDetail({required String token}) async {
    var r = await ApiService().apiJSONGetWitFirebaseToken('account',
        '/customer?id=true&name=true&email=true&phone=true&avatar=true', token);
    return r;
  }
}
