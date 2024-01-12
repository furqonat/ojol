import 'package:get/get.dart';
import 'package:lugo_marchant/page/running_order/api_runningorder.dart';
import 'package:lugo_marchant/page/running_order/controller_runningorder.dart';

class BindingRunningOrder implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerRunningOrder>(() => ControllerRunningOrder(api: ApiRunningOrder()));
  }
}