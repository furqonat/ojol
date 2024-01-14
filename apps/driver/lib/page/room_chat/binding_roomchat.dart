import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'api_roomchat.dart';

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