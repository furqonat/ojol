import 'package:flutter/widgets.dart';
import 'package:lugo_customer/api/api_service.dart';

class ApiFoodPay {
  Future<dynamic> getCart({required String token}) async {
    var r = await ApiService().apiJSONGetWitFirebaseToken('cart', token);
    return r;
  }

  Future<dynamic> updateCart(
      {required String id_product,
      required int quantity,
      required String token}) async {
    final body = {"productId": id_product, "quantity": quantity};

    debugPrint(body.toString());

    var r = await ApiService().apiJSONPutWithFirebaseToken('cart', body, token);
    return r;
  }
}
