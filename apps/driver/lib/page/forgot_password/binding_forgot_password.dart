import 'package:get/get.dart';

import 'controller_forgot_password.dart';

class BindingForgotPassword implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ControllerForgotPassword());
  }
}
