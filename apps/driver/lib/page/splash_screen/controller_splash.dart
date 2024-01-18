import 'package:get/get.dart';
import 'package:lugo_driver/route/route_name.dart';
import 'package:lugo_driver/shared/preferences.dart';

class ControllerSplash extends GetxController {
  final Preferences preferences;

  ControllerSplash({required this.preferences});
  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 3));
    final currentPage = preferences.getCurrentPage();
    if (currentPage == Routes.index) {
      Get.offAllNamed(Routes.auth);
      return;
    }
    Get.offAllNamed(currentPage);
    super.onInit();
  }
}
