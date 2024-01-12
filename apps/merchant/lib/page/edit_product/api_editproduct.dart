import 'package:rest_client/product_client.dart';

class ApiEditProduct {
  final ProductClient productClient;

  ApiEditProduct({required this.productClient});

  Future<dynamic> editProduct({
    required String name,
    required String description,
    required String image,
    required int price,
    required bool status,
    required String token,
  }) async {
    // TODO: add product ID
    final body = {
      "name": name,
      "description": description,
      "image": image,
      "price": price,
      "status": status,
    };

    var r = await productClient.updateProduct(
      bearerToken: "Bearer $token",
      productId: "",
      body: body,
    );
    return r;
  }
}
