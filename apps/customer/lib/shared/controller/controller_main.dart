import 'package:get/get.dart';
import 'package:lugo_customer/page/splash_screen/controller_splash.dart';
import 'package:lugo_customer/shared/controller/controller_user.dart';

class ControllerMain extends Bindings {
  @override
  void dependencies() {
    Get.put(ControllerSplash());
    Get.put(ControllerUser());
    // Get.put(ControllerNotification());
  }
}
