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

  final emailSignIn = TextEditingController();
  final passwordSignIn = TextEditingController();
  final emailSignUp = TextEditingController();
  final passwordSignUp = TextEditingController();
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
        email: emailSignIn.text,
        password: passwordSignIn.text,
      );
      preferences.setIsSignIn(true);
      Get.toNamed(Routes.phoneVerification);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    }
  }

  handleSignUp() async {
    final formState = signUpForm.currentState!.validate();
    final isValidPatner = partnerType.value != "Bergabung sebagai?";
    if (formState && isValidPatner) {
      preferences.setIsSignIn(false);
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailSignIn.text,
          password: passwordSignIn.text,
        );
        preferences.setIsSignIn(false);
        Get.toNamed(Routes.phoneVerification);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(msg: 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
        }
      }
      preferences.setReferal(referal.text);
      return;
    } else {
      Fluttertoast.showToast(msg: "please fill empty form");
    }
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    emailSignIn.dispose();
    passwordSignIn.dispose();
    referal.dispose();
    super.dispose();
  }
}
