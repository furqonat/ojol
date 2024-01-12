import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'api_chat.dart';

class ControllerChat extends GetxController{
  final ApiChat api;
  ControllerChat({required this.api});

  var samplechat = [
    {
      'user' : 'user_1',
      'msg' : 'oi',
      'attachment' : ''
    },
    {
      'user' : 'user_2',
      'msg' : 'apa?',
      'attachment' : ''
    },
    {
      'user' : 'user_1',
      'msg' : 'sudah di mana?',
      'attachment' : ''
    },
    {
      'user' : 'user_2',
      'msg' : 'di depan rumah, ini paket sudah sampai depan rumah lu, buka pintu nya',
      'attachment' : 'assets/images/paket_sampai.jpg'
    }
  ].obs;

  var edtChat = TextEditingController();

  @override
  void dispose() {
    edtChat.dispose();
    super.dispose();
  }

}