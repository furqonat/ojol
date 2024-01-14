import 'package:get/get.dart';
import 'package:lugo_marchant/page/welcome/controller_welcome.dart';

class BindingWelcome implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerWelcome>(() => ControllerWelcome());
  }
}