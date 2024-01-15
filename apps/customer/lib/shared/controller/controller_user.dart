import 'package:get/get.dart';
import 'package:lugo_customer/api/local_service.dart';
import 'package:lugo_customer/response/user.dart';

class ControllerUser extends GetxController {
  var user = UserResponse().obs;

  @override
  void onInit() async {
    super.onInit();
    await setUserData();
  }

  setUserData() async {
    var data = await LocalService().getUser();
    if (data != null) {
      user.value = UserResponse.fromJson(data);
    }
  }
}
