import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/profile/api_profile.dart';
import 'package:lugo_marchant/page/profile/controller_profile.dart';
import 'package:rest_client/account_client.dart';

class BindingProfile extends Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerProfile>(
      () => ControllerProfile(
        api: ApiProfile(
          accountClient: AccountClient(dio),
        ),
      ),
    );
  }
}
