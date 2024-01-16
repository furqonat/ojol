import 'package:lugo_driver/api/api_service.dart';
import 'package:lugo_driver/api/firestore_service.dart';

class ApiDashboard {
  Future<dynamic> acceptOrder(
      {required String order_id, required String token}) async {
    final sample = {"sample": "sample"};

    var r = await ApiService().apiJSONPutWithFirebaseToken(
        'order', 'driver/accept/$order_id', sample, token);
    return r;
  }

  Future<dynamic> rejectOrder(
      {required String order_id, required String token}) async {
    final sample = {"sample": "sample"};

    var r = await ApiService().apiJSONPutWithFirebaseToken(
        'order', 'driver/reject/$order_id', sample, token);
    return r;
  }

  Stream<List<T>> getOrder<T>(
      {required T Function(Map<String, dynamic> data) fromJson}) {
    var r =
        FirestoreService().FirestoreStreamGet<T>('order', fromJson: fromJson);
    return r;
  }

  Future<List<T>> getDriver<T>(
      {required T Function(Map<String, dynamic> data) fromJson}) async {
    var r = await FirestoreService().FirestoreFutureGet("drivers");
    return r.map<T>((e) => fromJson(e)).toList();
  }

  Future<dynamic> getDetailOrder(
      {required String order_id, required String token}) async {
    var r =
        await ApiService().apiJSONGetWitFirebaseToken('order', order_id, token);
    return r;
  }

  Future<dynamic> makeRoomChat({
    required String customer_name,
    required String merchant_name,
    required String driver_name,
    required String customer_id,
    required String merchant_id,
    required String driver_id,
    required bool status,
  }) async {
    final body = {
      "customer_name": customer_name,
      "merchant_name": merchant_name,
      "driver_name": driver_name,
      "customer_id": customer_id,
      "merchant_id": merchant_id,
      "driver_id": driver_id,
      "status": status,
    };

    var r = await FirestoreService().FirestorePost('room', body);
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

    var r = await FirestoreService().FirestorePost('drivers', body);
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

    return FirestoreService().FirestorePut("drivers", document, body);
  }
}
