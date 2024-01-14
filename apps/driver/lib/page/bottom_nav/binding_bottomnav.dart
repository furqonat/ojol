import 'package:get/get.dart';
import 'package:lugo_driver/page/bottom_nav/controller_bottomnav.dart';
import 'package:lugo_driver/page/history_order/api_historyorder.dart';
import 'package:lugo_driver/page/history_order/controller_historyorder.dart';
import 'package:lugo_driver/page/home/api_home.dart';
import 'package:lugo_driver/page/profile/api_profile.dart';
import 'package:lugo_driver/page/profile/controller_profile.dart';
import 'package:lugo_driver/page/room_chat/api_roomchat.dart';
import 'package:lugo_driver/page/room_chat/binding_roomchat.dart';
import 'package:lugo_driver/page/running_order/api_runningorder.dart';
import 'package:lugo_driver/page/running_order/controller_runningorder.dart';

import '../home/controller_home.dart';

class BindingBottomNav implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerBottomNav>(() => ControllerBottomNav());
    Get.lazyPut<ControllerHome>(() => ControllerHome(api: ApiHome()));
    Get.lazyPut<ControllerRoomChat>(() => ControllerRoomChat(api: ApiRoomChat()));
    Get.lazyPut<ControllerRunningOrder>(() => ControllerRunningOrder(api: ApiRunningOrder()));
    Get.lazyPut<ControllerHistoryOrder>(() => ControllerHistoryOrder(api: ApiHistoryOrder()));
    Get.lazyPut<ControllerProfile>(() => ControllerProfile(api: ApiProfile()));
  }
}