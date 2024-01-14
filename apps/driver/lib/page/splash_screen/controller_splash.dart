import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lugo_driver/api/local_serivce.dart';
import '../../route/route_name.dart';

class ControllerSplash extends GetxController{

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 3));
    if(await LocalService().getLoginStatus() == true){
      Get.offNamed(Routes.bottom_nav);
    }else{
      Get.offNamed(Routes.auth);
    }
    super.onInit();
  }
}