import 'package:get/get.dart';
import 'package:lugo_driver/page/main/controller_main.dart';
import 'package:lugo_driver/page/history_order/api_historyorder.dart';
import 'package:lugo_driver/page/history_order/controller_historyorder.dart';
import 'package:lugo_driver/page/dashboard/api_dashboard.dart';
import 'package:lugo_driver/page/profile/api_profile.dart';
import 'package:lugo_driver/page/profile/controller_profile.dart';
import 'package:lugo_driver/page/room_chat/api_roomchat.dart';
import 'package:lugo_driver/page/running_order/api_runningorder.dart';
import 'package:lugo_driver/page/running_order/controller_runningorder.dart';
import '../dashboard/controller_dashboard.dart';
import '../room_chat/controller_roomchat.dart';

class BindingMain implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerMain>(
      () => ControllerMain(),
    );
    Get.lazyPut<ControllerDashboard>(
      () => ControllerDashboard(
        api: ApiDashboard(),
      ),
    );
    Get.lazyPut<ControllerRoomChat>(
      () => ControllerRoomChat(
        api: ApiRoomChat(),
      ),
    );
    Get.lazyPut<ControllerRunningOrder>(
      () => ControllerRunningOrder(
        api: ApiRunningOrder(),
      ),
    );
    Get.lazyPut<ControllerHistoryOrder>(
      () => ControllerHistoryOrder(
        api: ApiHistoryOrder(),
      ),
    );
    Get.lazyPut<ControllerProfile>(
      () => ControllerProfile(
        api: ApiProfile(),
      ),
    );
  }
}
