import 'package:get/get.dart';
import 'package:lugo_marchant/page/splash_screen/controller_splash.dart';
import 'package:lugo_marchant/shared/controller/controller_notif.dart';
import 'package:lugo_marchant/shared/controller/controller_user.dart';

class MainController extends Bindings {
  @override
  void dependencies() {
    Get.put(ControllerSplash());
    Get.put(ControllerUser());
    Get.put(ControllerNotification());
  }
}
