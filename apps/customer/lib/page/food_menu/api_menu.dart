import 'package:lugo_customer/api/api_service.dart';

class ApiFoodMenu {
  Future<dynamic> getProducts(
      {required String token, required String merchantId}) async {
    var r = await ApiService().apiJSONGetWitFirebaseToken(
        'product',
        '?id=true&name=true&description=true&price=true&merchant_id=$merchantId&image=true&_count={select: {customer_product_review: true}}&favorites={select: {customer_id: true}}',
        token);
    return r;
  }

  Future<dynamic> postLikeProduct(
      {required String productId, required String token}) async {
    var r = await ApiService()
        .apiJSONGetWitFirebaseToken('product', 'favorite/$productId', token);
    return r;
  }

  Future<dynamic> cart(
      {required String productId,
      required int quantity,
      required String token}) async {
    final body = {'productId': productId, 'quantity': quantity};

    var r = await ApiService()
        .apiJSONPostWithFirebaseToken('cart', "cart", body, token);
    return r;
  }

  Future<dynamic> getBanner({required String token}) async => await ApiService()
      .apiJSONGetWitFirebaseToken('gate', 'lugo/banner', token);
}
