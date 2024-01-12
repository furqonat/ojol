import 'package:get/get.dart';
import 'package:lugo_customer/page/edit_profile/api_editprofile.dart';
import 'package:lugo_customer/page/edit_profile/controller_editprofile.dart';

class BindingEditProfile implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerEditProfile>(() => ControllerEditProfile(api: ApiEditProfile()));
  }
}