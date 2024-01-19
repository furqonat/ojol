import 'package:get/get.dart';
import 'package:lugo_customer/page/food_finish/api_foodfinish.dart';
import 'package:lugo_customer/page/food_finish/controller_foodfinish.dart';

class BindingFoodFinish implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerFoodFinish>(
        () => ControllerFoodFinish(api: ApiFoodFinish()));
  }
}
