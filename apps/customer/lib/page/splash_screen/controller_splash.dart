import 'package:get/get.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:lugo_customer/shared/local_storage.dart';

class ControllerSplash extends GetxController {
  final LocalStorage storage;

  ControllerSplash({required this.storage});

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (storage.isInVerification()) {
        Get.offNamed(storage.getVerifcationPage());
        return;
      } else {
        Get.offNamed(Routes.home);
      }
    });
    super.onInit();
  }
}
