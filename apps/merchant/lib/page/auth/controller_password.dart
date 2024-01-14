import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/route/route_name.dart';

class ControllerPassword extends GetxController
    with GetSingleTickerProviderStateMixin {
  final emailEditText = TextEditingController();
  final fAuth = FirebaseAuth.instance;

  void sendEmailResetPassword() {
    if (emailEditText.text.length > 3) {
      fAuth.sendPasswordResetEmail(email: emailEditText.text).then((value) {
        Fluttertoast.showToast(msg: "Succesfull send email verification");
        Get.offAllNamed(Routes.welcome);
      }).catchError((error) {
        Fluttertoast.showToast(msg: "Unable send reset password email $error");
      });
    }
    Fluttertoast.showToast(msg: "Not valid email. Please provide a real email");
  }

  @override
  void dispose() {
    emailEditText.dispose();
    super.dispose();
  }
}
