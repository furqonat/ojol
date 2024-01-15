import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/bottom_nav/controller_bottomnav.dart';
import 'package:lugo_marchant/page/history/api_history.dart';
import 'package:lugo_marchant/page/history/controller_history.dart';
import 'package:lugo_marchant/page/home/api_home.dart';
import 'package:lugo_marchant/page/home/controller_home.dart';
import 'package:lugo_marchant/page/profile/api_profile.dart';
import 'package:lugo_marchant/page/profile/controller_profile.dart';
import 'package:lugo_marchant/page/room_chat/api_roomchat.dart';
import 'package:lugo_marchant/page/room_chat/controller_roomchat.dart';
import 'package:lugo_marchant/page/running_order/api_runningorder.dart';
import 'package:lugo_marchant/page/running_order/controller_runningorder.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/gate_client.dart';
import 'package:rest_client/order_client.dart';

class BindingBottomNav implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerBottomNav>(
      () => ControllerBottomNav(),
    );
    Get.lazyPut<ControllerRoomChat>(
      () => ControllerRoomChat(
        api: ApiRoomChat(),
      ),
    );
    Get.lazyPut<ControllerHome>(
      () => ControllerHome(
        api: ApiHome(
          accountClient: AccountClient(dio),
          orderClient: OrderClient(dio),
          gateClient: GateClient(dio),
        ),
      ),
    );
    Get.lazyPut<ControllerHistory>(
      () => ControllerHistory(
        api: ApiHistory(
          orderClient: OrderClient(dio),
        ),
      ),
    );
    Get.lazyPut<ControllerRunningOrder>(
      () => ControllerRunningOrder(
        api: ApiRunningOrder(
          orderClient: OrderClient(dio),
        ),
      ),
    );
    Get.lazyPut<ControllerProfile>(
      () => ControllerProfile(
        api: ApiProfile(
          accountClient: AccountClient(dio),
        ),
      ),
    );
  }
}
