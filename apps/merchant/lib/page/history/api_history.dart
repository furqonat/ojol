import 'package:rest_client/order_client.dart';

class ApiHistory {
  final OrderClient orderClient;

  ApiHistory({required this.orderClient});

  Future getOrders({required String token}) async {
    final resp = await orderClient.merchantGetOrders(
      bearerToken: "Bearer $token",
    );
    return resp;
  }
}
