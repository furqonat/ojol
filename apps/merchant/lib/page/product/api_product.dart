import '../../api/api_service.dart';

class ApiProduct {
  Future<dynamic> getProducts(
      {required String token,
      required String userId,
      required String filter}) async {
    var r = await ApiService().apiJSONGetWitFirebaseToken(
        'product',
        '?id=true&name=true&description=true&price=true&filter=$filter&category=true&merchant_id=$userId&image=true&_count={select: {customer_product_review: true}}',
        token);
    return r;
  }
}
