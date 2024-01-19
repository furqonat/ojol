import 'package:get/get.dart';
import 'package:lugo_customer/page/food_pay/api_foodpay.dart';
import 'package:lugo_customer/page/food_pay/controller_foodpay.dart';

class BindingFoodPay implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerFoodPay>(() => ControllerFoodPay(api: ApiFoodPay()));
  }
}
