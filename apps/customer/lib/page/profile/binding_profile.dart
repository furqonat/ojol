import 'package:get/get.dart';
import 'package:lugo_customer/page/profile/api_profile.dart';
import 'package:lugo_customer/page/profile/controller_profile.dart';

class BindingProfile implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerProfile>(() => ControllerProfile(api: ApiProfile()));
  }
}
