import 'package:get/get.dart';
import 'package:lugo_driver/page/auth/api_auth.dart';
import 'controller_auth.dart';

class BindingAuth implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerAuth>(() => ControllerAuth(api: ApiAuth()));
  }
}