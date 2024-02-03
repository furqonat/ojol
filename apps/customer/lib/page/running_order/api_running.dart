import 'package:lugo_customer/api/api_service.dart';
import 'package:lugo_customer/api/firestore_service.dart';

class ApiRunning {
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

  Future<dynamic> getDriver(
          {required String driverId, required String token}) async =>
      await ApiService().apiJSONGetWitFirebaseToken(
          'account',
          'driver/$driverId/?id=true&name=true&email=true&avatar=true&driver_details={include: {vehicle: true}}',
          token);
}
