import 'package:get/get.dart';
import 'package:lugo_customer/page/discount/api_discount.dart';
import 'package:lugo_customer/page/discount/controller_discount.dart';

class BindingDiscount implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerDiscount>(
        () => ControllerDiscount(api: ApiDiscount()));
  }
}
