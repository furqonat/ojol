import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lugo_driver/page/auth/binding_auth.dart';
import 'package:lugo_driver/page/bottom_nav/binding_bottomnav.dart';
import 'package:lugo_driver/page/bottom_nav/page_bottomnav.dart';
import 'package:lugo_driver/page/chat/page_chat.dart';
import 'package:lugo_driver/page/form_join/binding_form.dart';
import 'package:lugo_driver/page/form_join/page_form.dart';
import 'package:lugo_driver/page/home/binding_home.dart';
import 'package:lugo_driver/page/home/page_home.dart';
import 'package:lugo_driver/page/order_finish/binding_orderfinish.dart';
import 'package:lugo_driver/page/order_finish/page_orderfinish.dart';
import 'package:lugo_driver/page/order_setting/binding_ordersetting.dart';
import 'package:lugo_driver/page/order_setting/page_ordersetting.dart';
import 'package:lugo_driver/page/room_chat/controller_roomchat.dart';
import 'package:lugo_driver/page/room_chat/page_roomchat.dart';
import 'package:lugo_driver/route/route_name.dart';
import '../page/auth/page_auth.dart';
import '../page/chat/binding_chat.dart';
import '../page/splash_screen/binding_splash.dart';
import '../page/splash_screen/page_splash.dart';

class RoutingPages{
  static final pages = [
    GetPage(
        name: Routes.INITIAL,
        page: ()=> const PageSplash(),
        binding: BindingSplash()
    ),
    GetPage(
        name: Routes.auth,
        page: ()=> const PageAuth(),
        binding: BindingAuth()
    ),
    GetPage(
        name: Routes.bottom_nav,
        page: ()=> const PageBottomNav(),
        binding: BindingBottomNav()
    ),
    GetPage(
        name: Routes.home,
        page: ()=> const PageHome(),
        binding: BindingHome()
    ),
    GetPage(
        name: Routes.order_finish,
        page: ()=> const PageOrderFinish(),
        binding: BindingOrderFinish()
    ),
    GetPage(
        name: Routes.room_chat,
        page: ()=> const PageRoomChat(),
        binding: BindingRoomChat()
    ),
    GetPage(
        name: Routes.chat,
        page: ()=> const PageChat(),
        binding: BindingChat()
    ),
    GetPage(
        name: Routes.order_setting,
        page: ()=> const PageOrderSetting(),
        binding: BindingOrderSetting()
    ),
    GetPage(
        name: Routes.form_join,
        page: ()=> const PageFormJoin(),
        binding: BindingFormJoin()
    ),
  ];
}