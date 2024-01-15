import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/history/api_history.dart';
import 'package:lugo_marchant/page/history/controller_history.dart';
import 'package:rest_client/order_client.dart';

class BindingHistory implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerHistory>(
      () => ControllerHistory(
        api: ApiHistory(
          orderClient: OrderClient(dio),
        ),
      ),
    );
  }
}
