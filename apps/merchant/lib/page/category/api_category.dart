import 'package:lugo_marchant/response/category.dart';
import 'package:rest_client/product_client.dart';
import 'package:rest_client/shared.dart';

class ApiCategory {
  final ProductClient productClient;

  ApiCategory({required this.productClient});

  Future<Response> createNewProduct() async {
    throw UnimplementedError();
  }

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
    required String categoryId,
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
        "connect": {"id": categoryId}
      }
    };

    final r = await productClient.createProduct(
      bearerToken: "Bearer $token",
      body: body,
    );
    return r;
  }

  Future<List<Category>> getMerchantCategories({required String token}) async {
    final resp = await productClient.getProductCategories(
      bearerToken: "Bearer $token",
    );
    return (resp['data'] as List<dynamic>)
        .map((e) => Category.fromJson(e))
        .toList();
  }

  Future<Response> createCategory(
      {required String token, required String name}) async {
    final body = {
      "name": name,
    };
    final resp = await productClient.createCategory(
      bearerToken: "Bearer $token",
      body: body,
    );
    return resp;
  }
}
