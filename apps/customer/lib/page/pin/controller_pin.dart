import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ControllerPin extends GetxController {
  var edtPin = TextEditingController();

  @override
  void dispose() {
    edtPin.dispose();
    super.dispose();
  }
}
