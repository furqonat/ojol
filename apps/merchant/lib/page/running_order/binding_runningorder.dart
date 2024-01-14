import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/running_order/api_runningorder.dart';
import 'package:lugo_marchant/page/running_order/controller_runningorder.dart';
import 'package:rest_client/order_client.dart';

class BindingRunningOrder implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerRunningOrder>(
      () => ControllerRunningOrder(
        api: ApiRunningOrder(
          orderClient: OrderClient(dio),
        ),
      ),
    );
  }
}
