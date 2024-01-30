import 'package:lugo_customer/api/api_service.dart';

class ApiMain {
  Future<dynamic> getBanner({required String token}) async => await ApiService()
      .apiJSONGetWitFirebaseToken('gate', 'lugo/banner', token);

  Future<dynamic> getRecomendedProduct({required String token}) async =>
      await ApiService().apiJSONGetWitFirebaseToken(
          'product',
          '?id=true&name=true&description=true&image=true&price=true&_count={select: {customer_product_review: true}}&favorites={select: {customer_id: true}}',
          token);

  Future<dynamic> safeDeviceToken(
          {required String deviceToken, required String token}) async =>
      await ApiService().apiJSONPostWithFirebaseToken(
          'account', 'customer/token', {'token': deviceToken}, token);
}
