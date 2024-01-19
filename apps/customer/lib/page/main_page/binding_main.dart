import 'package:get/get.dart';
import 'package:lugo_customer/page/main_page/api_main.dart';
import 'package:lugo_customer/page/main_page/controller_main.dart';

class BindingMain implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerMain>(() => ControllerMain(api: ApiMain()));
  }
}
