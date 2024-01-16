import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/response/room.dart';
import 'api_roomchat.dart';

class ControllerRoomChat<T> extends GetxController with GetSingleTickerProviderStateMixin{
  final ApiRoomChat api;
  ControllerRoomChat({required this.api});

  var edtSearch = TextEditingController();

  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    edtSearch.dispose();
    super.dispose();
  }

  Stream<List<RoomChat>> getRoomChat() {
    return api.getRoomChat(fromJson: (data) => RoomChat.fromJson(data));
  }
}