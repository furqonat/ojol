import 'package:rest_client/product_client.dart';
import 'package:rest_client/shared.dart';

class ApiCategory {
  final ProductClient productClient;

  ApiCategory({required this.productClient});
  Future<Response> addProductWithNewCategory({
    required String name,
    required String description,
    required String image,
    required int price,
    required bool status,
    required String productType,
    required String categoryName,
    required String token,
  }) async {
    final body = {
      "name": name,
      "description": description,
      "image": image,
      "price": price,
      "status": status,
      "product_type": productType,
      "category": {
        "create": {"name": categoryName}
      }
    };

    final r = await productClient.createProduct(
      bearerToken: "Bearer $token",
      body: body,
    );
    return r;
  }

  Future<Response> addProductWithCurrentCategory({
    required String name,
    required String description,
    required String image,
    required int price,
    required bool status,
    required String productType,
    required String id,
    required String token,
  }) async {
    final body = {
      "name": name,
      "description": description,
      "image": image,
      "price": price,
      "status": status,
      "product_type": productType,
      "category": {
        "connect": {"id": id}
      }
    };

    final r = await productClient.createProduct(
      bearerToken: "Bearer $token",
      body: body,
    );
    return r;
  }
}
