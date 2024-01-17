import 'package:get/get.dart';
import 'package:lugo_driver/page/splash_screen/controller_splash.dart';
import 'package:lugo_driver/shared/controller/controller_notif.dart';
import 'package:lugo_driver/shared/controller/controller_user.dart';

class ControllerMain extends Bindings {
  @override
  void dependencies() {
    Get.put(ControllerSplash());
    Get.put(ControllerNotification());
    Get.put(ControllerUser());
  }
}
