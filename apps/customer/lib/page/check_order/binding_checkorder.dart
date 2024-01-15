import 'package:get/get.dart';
import 'package:lugo_customer/page/check_order/api_checkorder.dart';
import 'package:lugo_customer/page/check_order/controller_checkorder.dart';

class BindingCheckOrder implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerCheckOrder>(
        () => ControllerCheckOrder(api: ApiCheckOrder()));
  }
}
