import 'package:get/get.dart';
import 'package:lugo_marchant/page/accout_info/api_accountinfo.dart';
import 'package:lugo_marchant/page/accout_info/controller_accountinfo.dart';

class BindingAccountInfo implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerAccountInfo>(() => ControllerAccountInfo(api: ApiAccountInfo()));
  }
}