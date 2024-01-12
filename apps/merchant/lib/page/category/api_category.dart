import 'package:lugo_marchant/api/api_service.dart';

class ApiCategory {
  Future<dynamic> addProductWithNewCategory({
    required String name,
    required String description,
    required String image,
    required int price,
    required bool status,
    required String product_type,
    required String category_name,
    required String token,
  }) async {
    final body = {
      "name": name,
      "description": description,
      "image": image,
      "price": price,
      "status": status,
      "product_type": product_type,
      "category": {
        "create": {"name": category_name}
      }
    };

    final r = await ApiService()
        .apiJSONPostWithFirebaseToken('product', '', body, token);
    return r;
  }

  Future<dynamic> addProductWithCurrentCategory({
    required String name,
    required String description,
    required String image,
    required int price,
    required bool status,
    required String product_type,
    required String id,
    required String token,
  }) async {
    final body = {
      "name": name,
      "description": description,
      "image": image,
      "price": price,
      "status": status,
      "product_type": product_type,
      "category": {
        "connect": {"id": id}
      }
    };

    final r = await ApiService()
        .apiJSONPostWithFirebaseToken('product', '', body, token);
    return r;
  }
}
