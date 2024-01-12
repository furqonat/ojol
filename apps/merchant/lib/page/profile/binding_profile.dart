import 'package:get/get.dart';
import 'package:lugo_marchant/page/profile/api_profile.dart';
import 'package:lugo_marchant/page/profile/controller_profile.dart';

class BindingProfile extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerProfile>(() => ControllerProfile(api: ApiProfile()));
  }
}