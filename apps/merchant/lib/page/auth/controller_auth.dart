import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/auth/api_auth.dart';
import 'package:lugo_marchant/page/verification/controller.dart';

import '../../api/local_service.dart';

enum AuthState {
  loading,
  idle,
  done,
}

class ControllerAuth extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiAuth api;
  ControllerAuth({required this.api});

  late TabController tabController;
  final selection = ["FOOD", "MART"];

  final formkeyAuthLogin = GlobalKey<FormState>();
  final formkeyAuthRegister = GlobalKey<FormState>();
  final formkeyformkeyPhone = GlobalKey<FormState>();
  final signInstate = AuthState.idle.obs;
  final signUpState = AuthState.idle.obs;
  final selectChip = 'FOOD'.obs;

  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();

  final edtEmailDaftar = TextEditingController();
  final edtPasswordDaftar = TextEditingController();

  final edtPhone = TextEditingController();
  final edtOTP = TextEditingController();

  final showPass = true.obs;

  //Login with firebase auth
  void handleSignIn() {
    try {
      signInstate.value = AuthState.loading;
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: edtEmail.text,
        password: edtPassword.text,
      )
          .then((value) async {
        final token = await FirebaseAuth.instance.currentUser?.getIdToken();
        final response = await api.claimToken(token: token!, body: null);
        if (response.message == "OK") {
          final newToken =
              await FirebaseAuth.instance.currentUser?.getIdToken(true);
          final resp = await api.getCurrentUser(newToken!);
          signInstate.value = AuthState.done;
          if (resp.detail == null) {
            await LocalService().setInVerification(true);
            await LocalService().setInVerificationStep(VerificationState.full);
            Get.offAllNamed("/verification/${VerificationState.full}");
          } else {
            await LocalService().setInVerification(true);
            await LocalService()
                .setInVerificationStep(VerificationState.phoneOnly);
            Get.offAllNamed("/verification/${VerificationState.phoneOnly}");
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      signInstate.value = AuthState.done;
      if (e.code == 'auth/user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'auth/invalid-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    }
  }

  //create with firebase auth
  void handleSignUp() {
    try {
      signUpState.value = AuthState.loading;
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: edtEmailDaftar.text,
        password: edtPasswordDaftar.text,
      )
          .then((value) async {
        if (value.user != null) {
          final token = await FirebaseAuth.instance.currentUser?.getIdToken();
          final response = await api
              .claimToken(token: token!, body: {"type": selectChip.value});
          if (response.message == 'OK' && response.token != null) {
            signUpState.value = AuthState.done;
            await LocalService().setInVerification(true);
            await LocalService().setInVerificationStep(VerificationState.full);
            Get.offAllNamed("/verification/${VerificationState.full}");
          } else {
            signUpState.value = AuthState.done;
            Fluttertoast.showToast(msg: "unable to signup");
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      signUpState.value = AuthState.done;
      if (e.code == 'auth/email-already-exists') {
        Fluttertoast.showToast(msg: 'This email already use by another user');
      }
    }
  }

  void handleSelectedChip(bool selected) {
    selectChip.value = selected && selectChip.value == 'FOOD'
        ? 'MART'
        : !selected && selectChip.value == 'MART'
            ? 'MART'
            : 'FOOD';
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    edtEmail.dispose();
    edtPassword.dispose();
    super.dispose();
  }
}
