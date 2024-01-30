import 'package:lugo_customer/api/api_service.dart';

class ApiOrderFinish {
  Future<dynamic> getDriver(
          {required String driverId, required String token}) async =>
      await ApiService().apiJSONGetWitFirebaseToken(
          'account',
          'driver/$driverId/?id=true&name=true&email=true&avatar=true&driver_details={include: {vehicle: true}}',
          token);
}
