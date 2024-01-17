import 'package:get/get.dart';
import 'api_form.dart';
import 'controller_form.dart';

class BindingFormJoin implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerFormJoin>(
        () => ControllerFormJoin(api: ApiFormJoin()));
  }
}
