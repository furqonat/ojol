import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lugo_driver/page/splash_screen/controller_splash.dart';
import 'package:lugo_driver/shared/preferences.dart';

class BindingSplash implements Bindings {
  @override
  void dependencies() {
    final preferences = GetStorage();
    Get.lazyPut<ControllerSplash>(
      () => ControllerSplash(
        preferences: Preferences(preferences),
      ),
    );
  }
}
