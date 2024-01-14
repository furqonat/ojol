import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/page/history_order/page_historyorder.dart';
import 'package:lugo_driver/page/home/page_home.dart';
import 'package:lugo_driver/page/profile/page_profile.dart';
import 'package:lugo_driver/page/room_chat/page_roomchat.dart';
import 'package:lugo_driver/page/running_order/page_runningorder.dart';

class ControllerBottomNav extends GetxController{
  late PageController pageController;

  var currentPage = 0.obs;

  final List<Widget> pages = [
    const PageHome(),
    const PageRunningOrder(),
    const PageHistoryOrder(),
    const PageRoomChat(),
    const PageProfile(),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentPage.value);
  }

  @override
  void onReady() {
    super.onReady();
    var pageArg = Get.arguments;
    if (pageArg != null) {
      changePage(pageArg);
      pageController.jumpToPage(pageArg);
    }
  }

  void changePage(index) => currentPage.value = index;
}