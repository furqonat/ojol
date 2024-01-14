import 'package:get/get.dart';
import 'controller_password.dart';

class BindingPassword implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerPassword>(() => ControllerPassword());
  }
}
