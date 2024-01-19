import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerForgotPassword extends GetxController {
  final _fbAuth = FirebaseAuth.instance;

  final emailController = TextEditingController();

  forgotPassword() {
    _fbAuth.sendPasswordResetEmail(email: emailController.text.trim()).then(
      (value) {
        Get.back();
        Get.snackbar(
          'Success',
          'We send you an email to reset your password, please check your email.',
        );
      },
    ).catchError(
      (error) {
        Get.snackbar(
          'Error',
          error.message.toString(),
        );
      },
    );
  }
}
