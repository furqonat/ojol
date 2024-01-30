import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lugo_customer/page/splash_screen/controller_splash.dart';
import 'package:lugo_customer/shared/local_storage.dart';

class BindingSplash implements Bindings {
  @override
  void dependencies() {
    final storage = GetStorage();
    Get.lazyPut<ControllerSplash>(
      () => ControllerSplash(
        storage: LocalStorage(storage: storage),
      ),
    );
  }
}
