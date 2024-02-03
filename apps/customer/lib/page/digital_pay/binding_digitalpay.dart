import 'package:get/get.dart';
import 'package:lugo_customer/page/digital_pay/controller_digitalpay.dart';

class BindingDigitalPay implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerDigitalPay>(() => ControllerDigitalPay());
  }
}
