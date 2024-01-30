import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lugo_customer/page/otp/api_otp.dart';
import 'package:lugo_customer/page/otp/controller_otp.dart';
import 'package:lugo_customer/shared/local_storage.dart';
import 'package:rest_client/account_client.dart';

class BindingOtp implements Bindings {
  @override
  void dependencies() {
    final client = AccountClient(Dio());
    final storage = LocalStorage(storage: GetStorage());
    Get.lazyPut<ControllerOtp>(
      () => ControllerOtp(
        api: ApiOtp(),
        accountClient: client,
        storage: storage,
      ),
    );
  }
}
