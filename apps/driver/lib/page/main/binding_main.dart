import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lugo_driver/api/local_serivce.dart';
import 'package:lugo_driver/page/main/controller_main.dart';
import 'package:lugo_driver/page/history_order/api_historyorder.dart';
import 'package:lugo_driver/page/history_order/controller_historyorder.dart';
import 'package:lugo_driver/page/dashboard/api_dashboard.dart';
import 'package:lugo_driver/page/profile/api_profile.dart';
import 'package:lugo_driver/page/profile/controller_profile.dart';
import 'package:lugo_driver/page/room_chat/api_roomchat.dart';
import 'package:lugo_driver/page/running_order/api_runningorder.dart';
import 'package:lugo_driver/page/running_order/controller_runningorder.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/order_client.dart';
import '../dashboard/controller_dashboard.dart';
import '../room_chat/controller_roomchat.dart';

class BindingMain implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerMain>(
      () => ControllerMain(),
    );
    Get.lazyPut<ControllerDashboard>(
      () => ControllerDashboard(
        api: ApiDashboard(),
        orderClient: OrderClient(dio),
        accountClient: AccountClient(dio),
        localService: LocalService(GetStorage()),
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
        localService: LocalService(GetStorage()),
      ),
    );
  }
}
