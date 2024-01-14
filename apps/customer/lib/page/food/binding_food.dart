import 'package:get/get.dart';
import 'package:lugo_customer/page/food/api_food.dart';
import 'package:lugo_customer/page/food/controller_food.dart';

class BindingFood implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerFood>(() => ControllerFood(api: ApiFood()));
  }
}