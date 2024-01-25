import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/response/commont.dart';
import 'package:lugo_marchant/response/dana.dart';
import 'package:lugo_marchant/response/user.dart';
import 'package:url_launcher/url_launcher.dart';

import 'api_home.dart';

class ControllerHome extends GetxController {
  ControllerHome({required this.api});
  final ApiHome api;

  final _fbAuth = FirebaseAuth.instance;
  final merchant = UserResponse().obs;
  final danaProfile = DanaProfile().obs;
  final sell = MerchantSellInDay(
    totalCancel: 0,
    totalDone: 0,
    totalIncome: 0,
  ).obs;
  final loadingDana = false.obs;

  Future<void> handleGetMerchant() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.getMerchant(token);
    merchant.value = resp;
    loadingDana.value = false;
    log("dana token ${resp.danaToken == null}");
    if (merchant.value.danaToken != null) {
      handleGetDanaProfile();
    }
  }

  Future<void> handleGetSell() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.getMerchantSellInDay(token!);
    log("resp ${resp.totalIncome}");
    sell.value = resp;
  }

  Future<void> handleGenerateSignInUrl() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.generateSignInUrl(token: token!);
    final url = Uri.parse(resp['signInUrl']);

    if (!await launchUrl(url)) {
      Fluttertoast.showToast(msg: "unable open url");
    }
  }

  handleAssignDeviceToken() async {
    final deviceToken = await FirebaseMessaging.instance.getToken();
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.applyDeviceToken(
      token: token!,
      deviceToken: deviceToken!,
    );
    print(resp.message);
  }

  handleGetDanaProfile() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.getDanaProfile(token: token!);
    danaProfile.value = resp;
    loadingDana.value = false;
  }

  @override
  void onReady() {
    loadingDana.value = true;
    handleGetMerchant();
    handleGetSell();

    super.onReady();
  }

  var listImg = [
    'assets/images/pamflet_1.jpg',
    'assets/images/pamflet_2.jpg',
    'assets/images/pamflet_3.jpg',
  ];
}
