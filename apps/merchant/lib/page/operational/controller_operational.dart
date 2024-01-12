import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_operational.dart';

class ControllerOperational extends GetxController {
  final ApiOperational api;
  ControllerOperational({required this.api});

  var shopStatus = false.obs;

  Rx<TimeOfDay> timeOpen = TimeOfDay.now().obs;
  Rx<TimeOfDay> timeClose = TimeOfDay.now().obs;

  static String getHari(int index) {
    switch (index) {
      case 0:
        return 'Senin';
      case 1:
        return 'Selasa';
      case 2:
        return 'Rabu';
      case 3:
        return 'Kamis';
      case 4:
        return "Jum'at";
      case 5:
        return 'Sabtu';
      case 6:
        return 'Minggu';
      default:
        return '';
    }
  }

  final List<Map<String, dynamic>> aInput = List.generate(7, (i) {
    final hari = getHari(i);
    return {
      'Hari': hari,
      'Jam buka': "hh:mm".obs,
      'Jam tutup': "hh:mm".obs,
      'Status': false.obs,
    };
  });

}

