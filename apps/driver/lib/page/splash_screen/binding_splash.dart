import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:lugo_driver/page/splash_screen/controller_splash.dart';

class BindingSplash implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerSplash>(() => ControllerSplash());
  }
}