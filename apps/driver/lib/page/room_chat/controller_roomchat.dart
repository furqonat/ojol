import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/response/room.dart';
import 'api_roomchat.dart';

class ControllerRoomChat<T> extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiRoomChat api;
  ControllerRoomChat({required this.api});

  late TabController tabController;

  var edtSearch = TextEditingController();

  final FirebaseAuth firebase = FirebaseAuth.instance;

  var idUser = ''.obs;

  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this);
    idUser.value = firebase.currentUser!.uid;
    super.onInit();
  }

  @override
  void dispose() {
    edtSearch.dispose();
    super.dispose();
  }

  Stream<List<RoomChat>> getRoomChat() =>
      FirebaseFirestore.instance
          .collection('room')
          .where('driver_id', isEqualTo: idUser.value)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((event) => event.docs.map((e) {
        return RoomChat.fromJson(e.data());
      }).toList().reversed.toList());
}
