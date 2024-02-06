import 'package:lugo_driver/api/api_service.dart';
import 'package:lugo_driver/api/firestore_service.dart';

class ApiDashboard {
  Future<dynamic> orderOtw({required String token, required String order_id}) async =>
      await ApiService().apiJSONPutWithFirebaseToken('order', 'driver/shipping/$order_id', {"": ""}, token);

  Future<dynamic> acceptOrder({required String orderId, required String token}) async {
    final sample = {"sample": "sample"};

    var r = await ApiService().apiJSONPutWithFirebaseToken(
        'order', 'driver/accept/$orderId', sample, token);
    return r;
  }

  Future<dynamic> rejectOrder({required String orderId, required String token}) async {
    final sample = {"sample": "sample"};

    var r = await ApiService().apiJSONPutWithFirebaseToken(
        'order', 'driver/reject/$orderId', sample, token);
    return r;
  }

  Stream<List<T>> getOrder<T>({required T Function(Map<String, dynamic> data) fromJson}) {
    var r =
        FirestoreService().firestoreStreamGet<T>('order', fromJson: fromJson);
    return r;
  }

  Future<List<T>> getDriver<T>({required T Function(Map<String, dynamic> data) fromJson}) async {
    var r = await FirestoreService().firestoreFutureGet("drivers");
    return r.map<T>((e) => fromJson(e)).toList();
  }

  Future<dynamic> getDetailOrder({required String orderId, required String token}) async {
    var r =
        await ApiService().apiJSONGetWitFirebaseToken('order', orderId, token);
    return r;
  }

  Future<dynamic> makeRoomChat({
    required String id,
    required String customer_id,
    required String merchant_id,
    required String driver_id,
    required DateTime dateTime,
    required bool status,
  }) async {
    final body = {
      "id": id,
      "customer_id": customer_id,
      "merchant_id": merchant_id,
      "driver_id": driver_id,
      "datetime": dateTime,
      "status": status,
    };

    var r = await FirestoreService().firestorePost('room', body);
    return r;
  }

  Future<dynamic> initialLocation(
      {required String id,
      required String address,
      required bool isOnline,
      required num latitude,
      required num longitude,
      required String name,
      required String type}) async {
    final body = {
      "id": id,
      "address": address,
      "isOnline": isOnline,
      "latitude": latitude,
      "longitude": longitude,
      "name": name,
      "type": type,
    };

    var r = await FirestoreService().firestorePost('drivers', body);
    return r;
  }

  Future<dynamic> listenLocation({
    required String id,
    required String address,
    required bool isOnline,
    required num latitude,
    required num longitude,
    required String name,
    required String type,
    required String document,
  }) async {
    final body = {
      "id": id,
      "address": address,
      "isOnline": isOnline,
      "latitude": latitude,
      "longitude": longitude,
      "name": name,
      "type": type,
    };

    return FirestoreService().firestorePut("drivers", document, body);
  }
}
