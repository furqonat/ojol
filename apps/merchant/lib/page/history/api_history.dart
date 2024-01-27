import 'package:rest_client/order_client.dart';

class ApiHistory {
  final OrderClient orderClient;

  ApiHistory({required this.orderClient});

  Future getOrders({required String token, required String time}) async {
    final resp = await orderClient.merchantGetOrderPeriod(
        bearerToken: "Bearer $token", time: time);
    return resp;
  }
}
