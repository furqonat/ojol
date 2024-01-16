import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../route/route_name.dart';

handleNotificationRoute(String screen, int? id, {int? secondId}) {
  log("disini $screen");
  switch (screen) {
    // Travel Screen
    case 'detail_travel':
      Get.toNamed(Routes.main, arguments: id);
      break;
    default:
  }
}

dismisKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

convertToIdr(dynamic number, int decimalDigit) {
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: decimalDigit,
  );
  return currencyFormatter.format(number);
}
