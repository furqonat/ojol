import 'package:lugo_driver/api/api_service.dart';
import 'package:lugo_driver/api/firestore_service.dart';

class ApiDashboard {
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
    required String customerName,
    required String merchantName,
    required String driverName,
    required String customerId,
    required String merchantId,
    required String driverId,
    required bool status,
  }) async {
    final body = {
      "customer_name": customerName,
      "merchant_name": merchantName,
      "driver_name": driverName,
      "customer_id": customerId,
      "merchant_id": merchantId,
      "driver_id": driverId,
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
