import 'package:get/get.dart';
import 'api_roomchat.dart';
import 'controller_roomchat.dart';

class BindingRoomChat implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerRoomChat>(
        () => ControllerRoomChat(api: ApiRoomChat()));
  }
}
