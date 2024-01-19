import 'package:get/get.dart';
import 'package:lugo_driver/route/route_name.dart';
import 'package:lugo_driver/shared/preferences.dart';

class ControllerSplash extends GetxController {
  final Preferences preferences;

  ControllerSplash({required this.preferences});
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 3));
    final alreadyJoin = preferences.getAlreadyJoin();
    final alreadySignIn = preferences.getAlreadySignIn();

    if (alreadySignIn && alreadyJoin) {
      Get.offAllNamed(Routes.main);
    } else if (alreadySignIn && !alreadyJoin) {
      Get.offAllNamed(Routes.phoneVerification);
    } else {
      Get.offAllNamed(Routes.auth);
    }
  }
}
