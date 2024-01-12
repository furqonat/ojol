import 'package:get/get.dart';
import 'package:lugo_customer/page/chat/api_chat.dart';
import 'package:lugo_customer/page/chat/controller_chat.dart';

class BindingChat implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerChat>(() => ControllerChat(api: ApiChat()));
  }
}