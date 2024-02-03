import 'package:lugo_customer/api/api_service.dart';
import 'package:lugo_customer/api/firestore_service.dart';

class ApiCheckOrder {
  Future<dynamic> findDriver(
      {required double latitude,
      required double longitude,
      required String orderId,
      required String token}) async {
    final body = {"latitude": latitude, "longitude": longitude};

    var r = await ApiService()
        .apiJSONPutWithFirebaseToken('order', 'driver/$orderId', body, token);
    return r;
  }

  Stream<T?> getOrder<T>(
      {required String documentId,
      required T Function(Map<String, dynamic> data) fromJson}) {
    var r = FirestoreService().firestoreSingleStreamGet<T>(
      'transactions',
      documentId,
      fromJson: fromJson,
    );
    return r;
  }

  Stream<T?> trackDriver<T>(
      {required String documentId,
      required T Function(Map<String, dynamic> data) fromJson}) {
    var r = FirestoreService().firestoreSingleStreamGet<T>(
      'drivers',
      documentId,
      fromJson: fromJson,
    );
    return r;
  }

  Future<dynamic> getDriver(
          {required String driverId, required String token}) async =>
      await ApiService().apiJSONGetWitFirebaseToken(
          'account',
          'driver/$driverId/?id=true&name=true&email=true&avatar=true&driver_details={include: {vehicle: true}}',
          token);

  Future<dynamic> cancelOrder(
          {required String orderId, required String token}) async =>
      await ApiService().apiJSONPutWithFirebaseToken(
          'order', orderId, {"sample": "sample"}, token);
}
