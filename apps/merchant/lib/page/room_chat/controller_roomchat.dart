import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../response/room.dart';
import 'api_roomchat.dart';

class ControllerRoomChat extends GetxController{
  final ApiRoomChat api;
  ControllerRoomChat({required this.api});

  var edtSearch = TextEditingController();

  Stream<List<RoomChat>> getRoomChat() {
    return api.getRoomChat(fromJson: (data) => RoomChat.fromJson(data));
  }

  @override
  void dispose() {
    edtSearch.dispose();
    super.dispose();
  }
}