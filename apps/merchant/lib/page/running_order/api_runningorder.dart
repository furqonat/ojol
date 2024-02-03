import 'package:rest_client/order_client.dart';

class ApiRunningOrder {
  final OrderClient orderClient;

  ApiRunningOrder({required this.orderClient});

  Future getOrders({required String token}) async {
    final resp =
        await orderClient.merchantGetOrder(bearerToken: "Bearer $token");
    return resp;
  }

  Future acceptOrder({required String token, required String orderId}) async {
    final resp = await orderClient.merchantAcceptOrder(
      bearerToken: token,
      orderId: orderId,
    );
    return resp;
  }

  Future rejectOrder({required String token, required String orderId}) async {
    final resp = await orderClient.merchantRejectOrder(
      bearerToken: token,
      orderId: orderId,
    );
    return resp;
  }

  Future findDriver({
    required String token,
    required String orderId,
    required Map<String, dynamic> body,
  }) async {
    final resp = await orderClient.orderFindDriver(
      bearerToken: "Bearer $token",
      orderId: orderId,
      body: body,
    );
    return resp;
  }
}
