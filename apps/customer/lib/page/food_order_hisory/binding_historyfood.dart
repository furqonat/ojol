import 'package:get/get.dart';
import 'package:lugo_customer/page/food_order_hisory/api_historyfood.dart';
import 'package:lugo_customer/page/food_order_hisory/controller_historyfood.dart';

class BindingHistoryFood implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerHistoryFood>(() => ControllerHistoryFood(api: ApiHistoryFood()));
  }
}