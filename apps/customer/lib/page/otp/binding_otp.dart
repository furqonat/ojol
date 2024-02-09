import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/otp/api_otp.dart';
import 'package:lugo_customer/page/otp/controller_otp.dart';
import 'package:rest_client/account_client.dart';

class BindingOtp implements Bindings {
  @override
  void dependencies() {
    final client = AccountClient(Dio());
    Get.lazyPut<ControllerOtp>(
      () => ControllerOtp(
        api: ApiOtp(),
        accountClient: client,
      ),
    );
  }
}
