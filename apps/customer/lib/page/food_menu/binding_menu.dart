import 'package:get/get.dart';
import 'api_menu.dart';
import 'controller_menu.dart';

class BindingFoodMenu implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerFoodMenu>(
        () => ControllerFoodMenu(api: ApiFoodMenu()));
  }
}
