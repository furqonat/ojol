import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:rest_client/auth_client.dart';

enum Status { idle, loading, success, failed }

class ControllerAuth extends GetxController
    with GetSingleTickerProviderStateMixin {
  ControllerAuth({required this.authClient});

  final AuthClient authClient;
  late TabController tabController;

  var loading = Status.idle.obs;

  final formSignIn = GlobalKey<FormState>();
  final formSignUp = GlobalKey<FormState>();

  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();

  final edtEmailDaftar = TextEditingController();
  final edtPasswordDaftar = TextEditingController();

  final showPass = true.obs;
  final loadingSignIn = false.obs;
  final loadingSignUp = false.obs;
  final _fbAuth = FirebaseAuth.instance;

  handlSignIn() {
    loadingSignIn.value = true;
    _fbAuth
        .signInWithEmailAndPassword(
      email: edtEmail.text,
      password: edtPassword.text,
    )
        .then((value) {
      final token = value.user?.getIdToken();
      authClient.customerSignIn(token: "Bearer $token").then((value) {
        loadingSignIn.value = false;
        Get.toNamed(Routes.otp);
      }).onError((error, stackTrace) {
        loadingSignIn.value = false;
        log(error.toString());
        log(stackTrace.toString());
        Fluttertoast.showToast(msg: error.toString());
      });
    }).catchError((error) {
      loadingSignIn.value = false;
      Fluttertoast.showToast(msg: "${error?.code?.toString()}");
    });
  }

  handleSignUp() async {
    loadingSignUp.value = true;
    _fbAuth
        .createUserWithEmailAndPassword(
      email: edtEmailDaftar.text,
      password: edtPasswordDaftar.text,
    )
        .then((value) async {
      value.user?.getIdToken().then((token) {
        authClient.customerSignIn(token: "Bearer $token").then((value) {
          loadingSignUp.value = false;
          Get.toNamed(Routes.otp);
        }).onError((error, stackTrace) {
          loadingSignUp.value = false;
          log(error.toString());
          log(stackTrace.toString());
          Get.snackbar(
            "Error",
            error.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
        });
      });
    }).catchError((error) {
      log(error.code.toString());
      loadingSignUp.value = false;
      Get.snackbar(
        "Error",
        "${error?.code?.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    });
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
    edtEmailDaftar.dispose();
    edtPasswordDaftar.dispose();
    super.dispose();
  }
}
