import 'package:get/get.dart';
import 'package:lugo_customer/page/menu/api_menu.dart';
import 'package:lugo_customer/page/menu/controller_menu.dart';

class BindingMenu implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerMenu>(() => ControllerMenu(api: ApiMenu()));
  }
}
