import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lugo_driver/page/splash_screen/controller_splash.dart';
import 'package:lugo_driver/shared/controller/controller_notification.dart';
import 'package:lugo_driver/shared/controller/controller_user.dart';
import 'package:lugo_driver/shared/preferences.dart';
import 'package:rest_client/account_client.dart';

class ControllerMain extends Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.put(
      ControllerSplash(
        preferences: Preferences(
          GetStorage(),
        ),
      ),
    );
    Get.put(
      ControllerNotification(
        accountClient: AccountClient(dio),
      ),
    );
    Get.put(ControllerUser());
  }
}
