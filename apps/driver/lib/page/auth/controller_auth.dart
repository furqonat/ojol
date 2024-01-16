import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/shared/preferences.dart';
import 'package:rest_client/auth_client.dart';

import '../../route/route_name.dart';

class ControllerAuth extends GetxController
    with GetSingleTickerProviderStateMixin {
  ControllerAuth({
    required this.authClient,
    required this.preferences,
  });

  final AuthClient authClient;
  final Preferences preferences;

  late TabController tabController;

  final signInForm = GlobalKey<FormState>();
  final signUpForm = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final referal = TextEditingController();

  final showPass = true.obs;

  final partnerList = [
    "Bergabung sebagai?",
    "BIKE",
    "CAR",
  ].obs;

  var partnerType = "Bergabung sebagai?".obs;

  handlSignIn() async {
    final isValid = signInForm.currentState!.validate();
    if (!isValid) {
      Fluttertoast.showToast(msg: "unable to verification");
      return;
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      Get.toNamed(Routes.phoneVerification);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    }
  }

  handleSignUp() {
    final formState = signUpForm.currentState!.validate();
    final isValidPatner = partnerType.value != "Bergabung sebagai?";
    if (formState && isValidPatner) {
      Get.toNamed(
        Routes.joinLugo,
        arguments: {
          'partner_type': partnerType.value,
          'referal': referal.text,
        },
      );
    }
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    referal.dispose();
    super.dispose();
  }
}
