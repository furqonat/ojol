import 'api_auth.dart';
import 'package:get/get.dart';
import 'controller_auth.dart';

class BindingAuth implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerAuth>(() => ControllerAuth(api: ApiAuth()));
  }
}