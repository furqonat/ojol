import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lugo_driver/api/local_serivce.dart';

import 'api_profile.dart';
import 'controller_profile.dart';

class BindingProfile implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerProfile>(
      () => ControllerProfile(
        api: ApiProfile(),
        localService: LocalService(GetStorage()),
      ),
    );
  }
}
