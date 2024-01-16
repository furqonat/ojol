import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lugo_driver/page/auth/binding_auth.dart';
import 'package:lugo_driver/page/auth/page_auth.dart';
import 'package:lugo_driver/page/main/binding_main.dart';
import 'package:lugo_driver/page/main/page_main.dart';
import 'package:lugo_driver/page/chat/binding_chat.dart';
import 'package:lugo_driver/page/chat/page_chat.dart';
import 'package:lugo_driver/page/form_join/binding_form.dart';
import 'package:lugo_driver/page/form_join/page_form.dart';
import 'package:lugo_driver/page/dashboard/binding_dashboard.dart';
import 'package:lugo_driver/page/dashboard/page_dashboard.dart';
import 'package:lugo_driver/page/order_finish/binding_orderfinish.dart';
import 'package:lugo_driver/page/order_finish/page_orderfinish.dart';
import 'package:lugo_driver/page/order_setting/binding_ordersetting.dart';
import 'package:lugo_driver/page/order_setting/page_ordersetting.dart';
import 'package:lugo_driver/page/phone_verification/binding_phone_verification.dart';
import 'package:lugo_driver/page/phone_verification/page_phone_verification.dart';
import 'package:lugo_driver/page/room_chat/binding_roomchat.dart';
import 'package:lugo_driver/page/room_chat/page_roomchat.dart';
import 'package:lugo_driver/page/splash_screen/binding_splash.dart';
import 'package:lugo_driver/page/splash_screen/page_splash.dart';
import 'package:lugo_driver/route/route_name.dart';

class RoutingPages {
  static final pages = [
    GetPage(
      name: Routes.index,
      page: () => const PageSplash(),
      binding: BindingSplash(),
    ),
    GetPage(
      name: Routes.auth,
      page: () => const PageAuth(),
      binding: BindingAuth(),
    ),
    GetPage(
      name: Routes.main,
      page: () => const PageMain(),
      binding: BindingMain(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const PageDashboard(),
      binding: BindingDashboard(),
    ),
    GetPage(
      name: Routes.orderFinish,
      page: () => const PageOrderFinish(),
      binding: BindingOrderFinish(),
    ),
    GetPage(
      name: Routes.roomChat,
      page: () => const PageRoomChat(),
      binding: BindingRoomChat(),
    ),
    GetPage(
      name: Routes.chat,
      page: () => const PageChat(),
      binding: BindingChat(),
    ),
    GetPage(
      name: Routes.orderSetting,
      page: () => const PageOrderSetting(),
      binding: BindingOrderSetting(),
    ),
    GetPage(
      name: Routes.joinLugo,
      page: () => const PageFormJoin(),
      binding: BindingFormJoin(),
    ),
    GetPage(
      name: Routes.phoneVerification,
      page: () => const PagePhoneVerification(),
      binding: BindingPhoneVerification(),
    ),
  ];
}
