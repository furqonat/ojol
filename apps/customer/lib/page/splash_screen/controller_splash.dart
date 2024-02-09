import 'package:get/get.dart';
import 'package:lugo_customer/api/local_service.dart';
import 'package:lugo_customer/route/route_name.dart';

class ControllerSplash extends GetxController {

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) async {
      var value = await LocalService().getIsSignIn();
        if (value == false) {
          var routes = await LocalService().getVerifcationPage();
        Get.offNamed(routes);
        return;
      } else {
        Get.offNamed(Routes.home);
      }
    });
    super.onInit();
  }
}
