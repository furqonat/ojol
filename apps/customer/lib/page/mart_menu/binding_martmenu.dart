import 'package:get/get.dart';
import 'package:lugo_customer/page/mart_menu/api_martmenu.dart';
import 'package:lugo_customer/page/mart_menu/controller_martmenu.dart';

class BindingMartMenu implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerMartMenu>(
        () => ControllerMartMenu(api: ApiMartMenu()));
  }
}
