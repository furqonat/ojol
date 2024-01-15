import 'package:get/get.dart';
import 'package:lugo_customer/page/auth/api_auth.dart';
import 'package:lugo_customer/page/auth/controller_auth.dart';

class BindingAuth implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerAuth>(() => ControllerAuth(api: ApiAuth()));
  }
}
