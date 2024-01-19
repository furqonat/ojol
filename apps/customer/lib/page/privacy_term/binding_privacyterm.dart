import 'package:get/get.dart';
import 'package:lugo_customer/page/privacy_term/controller_privacyterm.dart';

class BindingPrivacyTerm implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerPrivacyTerm>(() => ControllerPrivacyTerm());
  }
}
