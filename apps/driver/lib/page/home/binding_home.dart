import 'package:get/get.dart';
import 'package:lugo_driver/page/home/api_home.dart';
import 'controller_home.dart';

class BindingHome implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerHome>(() => ControllerHome(api: ApiHome()));
  }
}