import 'package:get/get.dart';
import 'package:lugo_customer/page/pin/controller_pin.dart';

class BindingPin implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerPin>(() => ControllerPin());
  }
}
