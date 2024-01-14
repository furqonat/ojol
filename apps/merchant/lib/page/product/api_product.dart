import 'package:lugo_marchant/response/category.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';
import 'package:rest_client/product_client.dart';

class ApiProduct {
  final ProductClient productClient;

  ApiProduct({required this.productClient});

  Future<dynamic> getProducts({
    required String token,
    required String merchantId,
    String? filter,
  }) async {
    final queryBuilder = QueryBuilder()
      ..addQuery("id", "true")
      ..addQuery("name", "true")
      ..addQuery("description", "true")
      ..addQuery("price", "true")
      ..addQuery("filter", filter)
      ..addQuery("merchant_id", merchantId)
      ..addQuery("image", "true")
      ..addQuery("category", "true")
      ..addQuery("_count", "{select: {customer_product_review: true}}");
    final resp = await productClient.getProducts(
      bearerToken: "Bearer $token",
      queries: queryBuilder.toMap(),
    );
    return resp;
  }

  Future<List<Category>> getCategories({required String token}) async {
    final resp = await productClient.getMerchantProductCategories(
      bearerToken: "Bearer $token",
    );
    print(resp);
    return (resp['data'] as List<dynamic>)
        .map((e) => Category(id: e['id'], name: e['name']))
        .toList();
  }
}
