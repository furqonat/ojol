import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/response/operation_time.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';
import 'package:rest_client/account_client.dart';

class ControllerOperational extends GetxController {
  ControllerOperational({
    required this.accountClient,
  });
  final AccountClient accountClient;
  final _fbAuth = FirebaseAuth.instance;
  var shopStatus = false.obs;
  final operationalTime = <OperationTime>[].obs;

  Rx<TimeOfDay> timeOpen = TimeOfDay.now().obs;
  Rx<TimeOfDay> timeClose = TimeOfDay.now().obs;

  handleGetMerchant() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final query = QueryBuilder()
      ..addQuery("id", "true")
      ..addQuery("details", "{include: {operation_time: true}}");
    final resp = await accountClient.getMerchant(
        bearerToken: "Bearer $token", queries: query.toMap());
    log("wait ${resp["details"]["operation_time"]}");
    operationalTime.value =
        (resp["details"]["operation_time"] as List).map((e) {
      return OperationTime.fromJson(e);
    }).toList();
  }

  handleSetOpTime(String day) async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final opTime = operationalTime.firstWhereOrNull((p0) => p0.day == day);
    if (opTime != null && opTime.id != null) {
      log("run on it, ${opTime.id}, ${opTime.endTime}, ${opTime.status}");

      final body = {
        "day": day,
        "open_time": opTime.startTime,
        "close_time": opTime.endTime,
        "status": opTime.status
      };
      log(body.toString());
      final resp = await accountClient.updateOperationTime(
        bearerToken: "Bearer $token",
        operationTimeId: opTime.id!,
        body: body,
      );
      log("${resp.res}");
      return;
    } else {
      log("${opTime?.startTime} ${opTime?.endTime} ${opTime?.status}");
      final body = {
        "create": {
          "day": day,
          "open_time": opTime?.startTime,
          "close_time": opTime?.endTime,
          "status": opTime?.status,
        }
      };
      log("run at new");
      log(body.toString());
      final resp = await accountClient.createOperationTime(
        bearerToken: "Bearer $token",
        body: body,
      );
      log(resp.message);
    }
  }

  String getDay(int index) {
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

  List<Map<String, dynamic>> aInput() => List.generate(7, (i) {
        final hari = getDay(i);

        return {
          'Hari': hari,
          'Jam buka': "hh:mm".obs,
          'Jam tutup': "hh:mm".obs,
          'Status': false.obs,
        };
      });

  String getOpenTime(String day) {
    final currentDay =
        operationalTime.firstWhereOrNull((p0) => p0.day == day)?.startTime;
    if (currentDay != null) {
      return currentDay;
    }
    return 'hh:mm';
  }

  void setOpenTime(String day, String time) {
    final currentDay = operationalTime.firstWhereOrNull((p0) => p0.day == day);
    if (currentDay != null) {
      // save current data
      final endTime = currentDay.endTime;
      final status = currentDay.status;
      final id = currentDay.id;
      // remove current
      final index = operationalTime.indexOf(currentDay);
      operationalTime.removeAt(index);
      // add new
      operationalTime.add(
        OperationTime(
          day: day,
          startTime: time,
          endTime: endTime,
          status: status,
          id: id,
        ),
      );
    }

    if (currentDay == null) {
      operationalTime.add(OperationTime(
        day: day,
        startTime: time,
        endTime: "hh:mm",
        status: false,
      ));
    }
  }

  String getCloseTime(String day) {
    final currentDay =
        operationalTime.firstWhereOrNull((p0) => p0.day == day)?.endTime;
    if (currentDay != null) {
      return currentDay;
    }
    return 'hh:mm';
  }

  void setCloseTime(String day, String time) {
    final currentDay = operationalTime.firstWhereOrNull((p0) => p0.day == day);
    if (currentDay != null) {
      // save current data
      final startTime = currentDay.startTime;
      final status = currentDay.status;
      final id = currentDay.id;
      // remove current
      final index = operationalTime.indexOf(currentDay);
      operationalTime.removeAt(index);
      // add new
      operationalTime.add(
        OperationTime(
          day: day,
          startTime: startTime,
          endTime: time,
          status: status,
          id: id,
        ),
      );
    }

    if (currentDay == null) {
      operationalTime.add(OperationTime(
        day: day,
        startTime: "hh:mm",
        endTime: time,
        status: false,
      ));
    }
  }

  bool getStatus(String day) {
    final currentDay =
        operationalTime.firstWhereOrNull((p0) => p0.day == day)?.status;
    if (currentDay != null) {
      return currentDay;
    }
    return false;
  }

  void setStatus(String day, bool status) {
    final currentDay = operationalTime.firstWhereOrNull((p0) => p0.day == day);
    if (currentDay != null) {
      // save current data
      final startTime = currentDay.startTime;
      final endTime = currentDay.endTime;
      final id = currentDay.id;
      // remove current
      final index = operationalTime.indexOf(currentDay);
      operationalTime.removeAt(index);
      // add new
      operationalTime.add(
        OperationTime(
          day: day,
          startTime: startTime,
          endTime: endTime,
          status: status,
          id: id,
        ),
      );
    }

    if (currentDay == null) {
      operationalTime.add(OperationTime(
        day: day,
        startTime: "hh:mm",
        endTime: "hh:mm",
        status: status,
      ));
    }
  }

  @override
  void onInit() {
    handleGetMerchant();
    super.onInit();
  }
}
