import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/api/local_service.dart';
import 'package:lugo_customer/page/room_chat/api_roomchat.dart';
import 'package:lugo_customer/response/roomchat.dart';
import 'package:lugo_customer/shared/controller/controller_user.dart';

class ControllerRoomChat extends GetxController {
  final ApiRoomChat api;
  ControllerRoomChat({required this.api});

  var edtSearch = TextEditingController();

  final ControllerUser controllerUser = Get.find<ControllerUser>();

  var id = ''.obs;


  @override
  void onInit() async {
    var room = await LocalService().getTransactionId();
    if(room != null){
      id(room);
    }
    super.onInit();
  }

  Stream<List<RoomChat>> getRoomChat() =>
      FirebaseFirestore.instance
          .collection('room')
          .where('customer_id', isEqualTo: controllerUser.user.value.id)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((event) => event.docs.map((e) {
        return RoomChat.fromJson(e.data());
      }).toList().reversed.toList());

  @override
  void dispose() {
    edtSearch.dispose();
    super.dispose();
  }
}
