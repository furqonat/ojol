import 'package:get/get.dart';
import 'package:lugo_marchant/api/local_service.dart';
import 'package:lugo_marchant/route/route_name.dart';

class ControllerSplash extends GetxController {
  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 3));
    if (await LocalService().isInVerification()) {
      final verificationStep = await LocalService().getInVerificationStep();
      Get.offNamed("/verification/$verificationStep");
      return;
    }
    if (await LocalService().getLoginStatus()) {
      Get.offNamed(Routes.bottomNav);
      return;
    } else {
      Get.offNamed(Routes.welcome);
    }
    super.onInit();
  }
}
