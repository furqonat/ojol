import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../api/local_serivce.dart';
import '../../response/user.dart';

class ControllerUser extends GetxController {
  final store = GetStorage();
  var user = UserResponse().obs;

  @override
  void onInit() async {
    super.onInit();
    await setUserData();
  }

  setUserData() async {
    var data = await LocalService(store).getUser();
    if (data != null) {
      user.value = UserResponse.fromJson(data);
    }
  }
}
