import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  handleGetOrder() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.getOrders(token: token!);
    print(resp);
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

  handleAcceptOrder(String orderId) async {
    final token = await _fbAuth.currentUser?.getIdToken();
    await api.acceptOrder(token: token!, orderId: orderId);
  }

  handleReject(String orderId) async {
    final token = await _fbAuth.currentUser?.getIdToken();
    await api.rejectOrder(token: token!, orderId: orderId);
  }

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    handleGetOrder();
    super.onInit();
  }
}
