import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../route/route_name.dart';

handleNotificationRoute(String screen, int? id, {int? secondId}) {
  log("disini $screen");
  switch (screen) {
  // Travel Screen
    case 'detail_travel':
      Get.toNamed(Routes.home, arguments: id);
      break;
    default:
  }
}

dismisKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}