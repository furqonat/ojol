import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../route/route_name.dart';

handleNotificationRoute(String screen, int? id, {int? secondId}) {
  switch (screen) {
    case 'detail_travel':
      Get.toNamed(Routes.home, arguments: id);
      break;
    default:
  }
}

dismisKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String intlNumberCurrency(dynamic value) {
  if (value == null || value == "") {
    return "";
  }
  return NumberFormat.simpleCurrency(locale: 'id_ID').format(value);
}
