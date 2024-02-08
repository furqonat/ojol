import 'package:lugo_driver/api/api_service.dart';

class ApiRunningOrder {
  Future<dynamic> listOrder(String token) async {
    var r = await ApiService().apiJSONGetWitFirebaseToken('order', 'driver', token);
    return r;
  }

  Future<dynamic> orderAccept({required String orderId, required String token}) async {
    var r = await ApiService().apiJSONPutWithFirebaseToken('order', 'driver/sign/$orderId', {"" : ""}, token);
    return r;
  }

  Future<dynamic> getDetailOrder({required String order_id, required String token})async =>
      await ApiService().apiJSONGetWitFirebaseToken('order', order_id, token);
}
