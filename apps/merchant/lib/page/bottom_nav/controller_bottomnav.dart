import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/history/page_history.dart';
import 'package:lugo_marchant/page/home/page_home.dart';
import 'package:lugo_marchant/page/profile/page_profile.dart';
import 'package:lugo_marchant/page/room_chat/page_roomchat.dart';
import 'package:lugo_marchant/page/running_order/page_runningorder.dart';

class ControllerBottomNav extends GetxController {
  late PageController pageController;

  var currentPage = 0.obs;

  final List<Widget> pages = [
    const PageHome(),
    const PageRunningOrder(),
    const PageHistory(),
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
      update();
    }
  }

  void changePage(index) {
    update();
    currentPage.value = index;
  }
}
