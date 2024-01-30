import 'package:lugo_customer/api/api_service.dart';

class ApiHistory {

  Future<dynamic> getHistoryOrder(String token) async =>
      await ApiService().apiJSONGetWitFirebaseToken('order', 'customer', token);

}
