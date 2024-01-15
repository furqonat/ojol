import 'package:get/get.dart';
import 'package:lugo_customer/page/otp/api_otp.dart';
import 'package:lugo_customer/page/otp/controller_otp.dart';

class BindingOtp implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerOtp>(() => ControllerOtp(api: ApiOtp()));
  }
}
