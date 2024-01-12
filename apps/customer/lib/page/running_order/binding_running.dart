import 'package:get/get.dart';
import 'package:lugo_customer/page/running_order/api_running.dart';
import 'package:lugo_customer/page/running_order/controller_running.dart';

class BindingRunning implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerRunning>(() => ControllerRunning(api: ApiRunning()));
  }

}