import 'package:get/get.dart';
import 'package:lugo_marchant/page/home/api_home.dart';
import 'package:lugo_marchant/page/home/controller_home.dart';

class BindingHome implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerHome>(() => ControllerHome(api: ApiHome()));
  }
}