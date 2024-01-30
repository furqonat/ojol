import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lugo_customer/page/splash_screen/controller_splash.dart';
import 'package:lugo_customer/shared/controller/controller_notif.dart';
import 'package:lugo_customer/shared/controller/controller_user.dart';
import 'package:lugo_customer/shared/local_storage.dart';

class ControllerMain extends Bindings {
  @override
  void dependencies() {
    final storage = LocalStorage(storage: GetStorage());
    Get.put(ControllerSplash(storage: storage));
    Get.put(ControllerUser());
    Get.put(ControllerNotification());
  }
}
