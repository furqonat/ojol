import 'package:lugo_marchant/shared/servinces/url_service.dart';
import 'package:rest_client/product_client.dart';
import 'package:rest_client/shared.dart';

class ApiEditProduct {
  final ProductClient productClient;

  ApiEditProduct({required this.productClient});

  Future<Response> editProduct({
    required String name,
    required String description,
    required String image,
    required int price,
    required bool status,
    required String productId,
    required String token,
  }) async {
    final body = {
      "name": name,
      "description": description,
      "image": image,
      "price": price,
      "status": status,
    };

    var r = await productClient.updateProduct(
      bearerToken: "Bearer $token",
      productId: productId,
      body: body,
    );
    return r;
  }

  Future getProduct({required String productId, required String token}) async {
    final query = QueryBuilder()
      ..addQuery("id", "true")
      ..addQuery("name", "true")
      ..addQuery("price", "true")
      ..addQuery("description", "true")
      ..addQuery("status", "true")
      ..addQuery("image", "true")
      ..addQuery("category", "true");
    final resp = await productClient.getProduct(
      bearerToken: "Bearer $token",
      productId: productId,
      queries: query.toMap(),
    );
    return resp;
  }
}
