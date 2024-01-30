import 'package:get/get.dart';
import 'package:lugo_customer/page/room_chat/api_roomchat.dart';
import 'package:lugo_customer/page/room_chat/controller_roomchat.dart';

class BindingRoomChat implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerRoomChat>(
        () => ControllerRoomChat(api: ApiRoomChat()));
  }
}
