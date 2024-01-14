import 'package:get/get.dart';

import 'api_chat.dart';
import 'controller_chat.dart';

class BindingChat implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerChat>(() => ControllerChat(api: ApiChat()));
  }
}
