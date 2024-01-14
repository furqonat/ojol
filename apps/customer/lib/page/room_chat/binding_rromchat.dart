import 'package:get/get.dart';
import 'package:lugo_customer/page/room_chat/api_rromchat.dart';
import 'package:lugo_customer/page/room_chat/controller_rromchat.dart';

class BindingRoomChat implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerRoomChat>(() => ControllerRoomChat(api: ApiRoomChat()));
  }
}