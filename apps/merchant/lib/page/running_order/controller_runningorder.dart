import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/running_order/api_runningorder.dart';

class ControllerRunningOrder extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiRunningOrder api;
  ControllerRunningOrder({required this.api});

  final _fbAuth = FirebaseAuth.instance;
  late TabController tabController;
  final newOrder = <Map<String, dynamic>>[].obs;
  final proccess = <Map<String, dynamic>>[].obs;
  final done = <Map<String, dynamic>>[].obs;
  final loadingAccept = false.obs;
  final loadingReject = false.obs;

  handleGetOrder() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.getOrders(token: token!);
    log("response running order ${resp['process']}");
    newOrder(
      (resp['cancel'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
    proccess(
      (resp['process'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
    done(
      (resp['done'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  handleAcceptOrder(String orderId) async {
    loadingAccept.value = true;
    final token = await _fbAuth.currentUser?.getIdToken();
    await api.acceptOrder(token: token!, orderId: orderId);
    _determinePosition().then((value) {
      final body = {
        "latitude": value.latitude,
        "longitude": value.longitude,
      };
      api.findDriver(token: token, orderId: orderId, body: body).then((value) {
        loadingAccept.value = false;
        handleGetOrder();
      });
    }).catchError((error) {
      loadingAccept.value = false;
      Get.snackbar("Error", error.toString());
    });
  }

  handleReject(String orderId) async {
    loadingReject.value = true;
    final token = await _fbAuth.currentUser?.getIdToken();
    await api.rejectOrder(token: token!, orderId: orderId);
    loadingReject.value = false;
    handleGetOrder();
  }

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    log("on init running order");
    handleGetOrder();
    super.onInit();
  }
}
