import 'package:get/get.dart';
import 'package:lugo_marchant/page/privacy_terms/controller_privacy.dart';

class BindingPrivacy implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerPrivacy>(() => ControllerPrivacy());
  }
}