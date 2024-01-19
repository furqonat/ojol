import 'package:get/get.dart';
import 'package:lugo_customer/api/local_service.dart';
import 'package:lugo_customer/route/route_name.dart';

class ControllerSplash extends GetxController {
  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 3));
    if (await LocalService().getLoginStatus() == true) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offNamed(Routes.auth);
    }
    super.onInit();
  }
}
