import 'package:get/get.dart';
import 'package:lugo_marchant/page/operational/api_operational.dart';
import 'package:lugo_marchant/page/operational/controller_operational.dart';

class BindingOperational implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerOperational>(
        () => ControllerOperational(api: ApiOperational()));
  }
}
