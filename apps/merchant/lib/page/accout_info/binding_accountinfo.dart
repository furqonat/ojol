import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/accout_info/api_accountinfo.dart';
import 'package:lugo_marchant/page/accout_info/controller_accountinfo.dart';
import 'package:rest_client/account_client.dart';

class BindingAccountInfo implements Bindings {
  @override
  void dependencies() {
    final Dio dio = Dio();
    Get.lazyPut<ControllerAccountInfo>(
      () => ControllerAccountInfo(
        api: ApiAccountInfo(
          accountClient: AccountClient(dio),
        ),
      ),
    );
  }
}
