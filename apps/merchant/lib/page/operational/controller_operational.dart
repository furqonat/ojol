import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';
import 'package:rest_client/account_client.dart';

class ControllerOperational extends GetxController {
  ControllerOperational({
    required this.accountClient,
  });
  final AccountClient accountClient;
  final _fbAuth = FirebaseAuth.instance;
  var shopStatus = false.obs;

  Rx<TimeOfDay> timeOpen = TimeOfDay.now().obs;
  Rx<TimeOfDay> timeClose = TimeOfDay.now().obs;

  handleGetMerchant() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final query = QueryBuilder()
      ..addQuery("id", "true")
      ..addQuery("details", "{include: {operation_time: true}}");
    final resp = await accountClient.getMerchant(
        bearerToken: "Bearer $token", queries: query.toMap());
    log("$resp");
  }

  handleSetOpTime(String day, {openTime, closeTime, status = false}) async {
    final body = {
      "day": day,
      "open_time": openTime,
      "close_time": closeTime,
      "status": status
    };
    log(body.toString());
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await accountClient.createOperationTime(
      bearerToken: "Bearer $token",
      body: body,
    );
    log(resp.message);
  }

  static String getDay(int index) {
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
    final hari = getDay(i);
    return {
      'Hari': hari,
      'Jam buka': "hh:mm".obs,
      'Jam tutup': "hh:mm".obs,
      'Status': false.obs,
    };
  });

  @override
  void onInit() {
    super.onInit();
    handleGetMerchant();
  }
}
