import 'package:get/get.dart';
import 'package:lugo_customer/page/history_order/api_history.dart';
import 'package:lugo_customer/page/history_order/controller_history.dart';
import 'package:lugo_customer/page/home/controller_home.dart';
import 'package:lugo_customer/page/main_page/api_main.dart';
import 'package:lugo_customer/page/main_page/controller_main.dart';
import 'package:lugo_customer/page/profile/api_profile.dart';
import 'package:lugo_customer/page/profile/controller_profile.dart';
import 'package:lugo_customer/page/room_chat/api_rromchat.dart';
import 'package:lugo_customer/page/room_chat/controller_rromchat.dart';
import 'package:lugo_customer/page/running_order/api_running.dart';
import 'package:lugo_customer/page/running_order/controller_running.dart';

class BindingHome implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerHome>(() => ControllerHome());
    Get.lazyPut<ControllerMain>(() => ControllerMain(api: ApiMain()));
    Get.lazyPut<ControllerRoomChat>(
        () => ControllerRoomChat(api: ApiRoomChat()));
    Get.lazyPut<ControllerHistory>(() => ControllerHistory(api: ApiHistory()));
    Get.lazyPut<ControllerRunning>(() => ControllerRunning(api: ApiRunning()));
    Get.lazyPut<ControllerProfile>(() => ControllerProfile(api: ApiProfile()));
  }
}
