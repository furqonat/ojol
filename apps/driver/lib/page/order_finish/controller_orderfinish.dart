import 'dart:convert';

import 'package:get/get.dart';
import 'package:lugo_driver/shared/preferences.dart';

import '../../response/order.dart';
import '../../shared/controller/controller_user.dart';
import 'api_orderfinish.dart';

class ControllerOrderFinish extends GetxController {
  final ApiOrderFinish api;
  ControllerOrderFinish({required this.api});

  ControllerUser controllerUser = Get.find<ControllerUser>();

  Rx<Order> orderDetail = Order().obs;

  @override
  void onInit() async {
    var getter = Preferences(LocalStorage.instance).getOrder();
    var decoder = jsonDecode(getter);
    orderDetail.value = Order.fromJson(decoder);
    super.onInit();
  }

}
