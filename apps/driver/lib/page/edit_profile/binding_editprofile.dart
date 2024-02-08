import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/page/edit_profile/controller_editprofile.dart';
import 'package:rest_client/account_client.dart';

class BindingEditProfile implements Bindings{
  final dio = Dio();
  @override
  void dependencies() {
    Get.lazyPut(() => ControllerEditProfile(accountClient: AccountClient(dio)));
  }
}
