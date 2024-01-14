import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/room_chat/api_rromchat.dart';

class ControllerRoomChat extends GetxController{
  final ApiRoomChat api;
  ControllerRoomChat({required this.api});

  var edtSearch = TextEditingController();

  @override
  void dispose() {
    edtSearch.dispose();
    super.dispose();
  }
}