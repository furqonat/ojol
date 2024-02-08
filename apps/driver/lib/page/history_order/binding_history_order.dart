import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/page/history_order/api_history_order.dart';
import 'package:rest_client/transaction_client.dart';

import 'controller_history_order.dart';

class BindingHistoryOrder implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerHistoryOrder>(
      () => ControllerHistoryOrder(
        api: ApiHistoryOrder(),
        transactionClient: TransactionClient(dio),
      ),
    );
  }
}
