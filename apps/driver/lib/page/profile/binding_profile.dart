import 'package:get/get.dart';

import 'api_profile.dart';
import 'controller_profile.dart';

class BindingProfile implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerProfile>(() => ControllerProfile(api: ApiProfile()));
  }
}