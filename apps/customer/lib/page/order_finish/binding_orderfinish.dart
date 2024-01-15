import 'package:get/get.dart';
import 'package:lugo_customer/page/order_finish/api_orderfinish.dart';
import 'package:lugo_customer/page/order_finish/controller_orderfinish.dart';

class BindingOrderFinish implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerOrderFinish>(
        () => ControllerOrderFinish(api: ApiOrderFinish()));
  }
}
