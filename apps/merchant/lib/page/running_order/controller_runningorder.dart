import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/running_order/api_runningorder.dart';

class ControllerRunningOrder extends GetxController with GetSingleTickerProviderStateMixin{
  final ApiRunningOrder api;
  ControllerRunningOrder({required this.api});

  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }
}