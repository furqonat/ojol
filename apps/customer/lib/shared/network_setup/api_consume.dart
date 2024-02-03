import 'package:lugo_customer/api/api_service.dart';

class ApiConsume {
  Future<dynamic> assignDeviceToken(
          {required String deviceToken, required String token}) async =>
      await ApiService().apiJSONPostWithFirebaseToken(
        'account',
        'customer/token',
        {'token': deviceToken},
        token,
      );
}
