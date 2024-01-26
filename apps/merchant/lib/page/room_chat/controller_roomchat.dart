import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../response/room.dart';
import 'api_roomchat.dart';

class ControllerRoomChat extends GetxController {
  final ApiRoomChat api;
  ControllerRoomChat({required this.api});

  var edtSearch = TextEditingController();

  var idUser = ''.obs;

  final FirebaseAuth firebase = FirebaseAuth.instance;

  Stream<List<RoomChat>> getRoomChat() => FirebaseFirestore.instance
      .collection('room')
      .where('merchant_id', isEqualTo: idUser.value)
      .orderBy('datetime', descending: true)
      .snapshots()
      .map((event) => event.docs
          .map((e) {
            return RoomChat.fromJson(e.data());
          })
          .toList()
          .reversed
          .toList());

  @override
  void onInit() {
    idUser.value = firebase.currentUser?.uid ?? '';
    super.onInit();
  }

  @override
  void dispose() {
    edtSearch.dispose();
    super.dispose();
  }
}
