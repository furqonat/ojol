import 'package:get/get.dart';
import 'package:lugo_driver/page/running_order/api_runningorder.dart';
import 'controller_runningorder.dart';

class BindingRunningOrder implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerRunningOrder>(
        () => ControllerRunningOrder(api: ApiRunningOrder()));
  }
}
