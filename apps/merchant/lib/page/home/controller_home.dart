import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/response/commont.dart';
import 'package:lugo_marchant/response/user.dart';

import 'api_home.dart';

class ControllerHome extends GetxController {
  final ApiHome api;
  ControllerHome({required this.api});
  final merchant = UserResponse().obs;
  final _fbAuth = FirebaseAuth.instance;
  final sell = MerchantSellInDay(
    totalCancel: 0,
    totalDone: 0,
    totalIncome: 0,
  ).obs;

  Future<void> handleGetMerchant() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.getMerchant(token);
    merchant.value = resp;
  }

  Future<void> handleGetSell() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.getMerchantSellInDay(token!);
    sell.value = resp;
  }

  @override
  void onReady() {
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
