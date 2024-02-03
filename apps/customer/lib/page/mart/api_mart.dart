import 'package:lugo_customer/api/api_service.dart';

class ApiMart {
  Future<dynamic> getMerchant({required String token}) async => await ApiService().apiJSONGetWitFirebaseToken(
        'product',
        'merchants?id=true&type=MART&details={select: {address: true, name: true, images: true}}',
        token);

  Future<dynamic> getBanner({required String token})async =>
      await ApiService().apiJSONGetWitFirebaseToken('gate', 'lugo/banner', token);
}
