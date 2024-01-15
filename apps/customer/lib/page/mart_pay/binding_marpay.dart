import 'package:get/get.dart';
import 'package:lugo_customer/page/mart_pay/api_marpay.dart';
import 'package:lugo_customer/page/mart_pay/controller_marpay.dart';

class BindingMartPay implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerMartPay>(() => ControllerMartPay(api: ApiMartPay()));
  }
}
