import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/balance/api_balance.dart';
import 'package:lugo_marchant/response/user.dart';
import 'package:rest_client/shared.dart';

class ControllerBalance extends GetxController {
  final ApiBalance apiBalance;

  ControllerBalance({required this.apiBalance});

  final merchant = UserResponse().obs;
  final amountWd = TextEditingController();
  final amountTp = TextEditingController();
  final _fbAuth = FirebaseAuth.instance;
  final checkoutUrl = ''.obs;
  final transaction = <Transaction>[].obs;
  final orderList = [
    "Bulan Ini",
    "Minggu Ini",
    "Hari Ini",
  ].obs;
  final isRequestWd = false.obs;

  handleGetTrx([trxIn = "month"]) async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await apiBalance.getMerchantTransactions(
      token: token!,
      trxIn: trxIn,
    );
    transaction.value = resp;
  }

  final orderValue = "Bulan Ini".obs;
  handleGetMerchant() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await apiBalance.getMerchant(token);
    merchant.value = resp;
  }

  Future<String> handleTopUp() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await apiBalance.topUp(
      token: token!,
      amount: int.parse(amountTp.text),
    );
    if (resp['checkoutUrl'] != '') {
      return resp['checkoutUrl'];
    }
    return '';
  }

  handleWithdraw() async {
    isRequestWd.value = true;
    try {
      final token = await _fbAuth.currentUser?.getIdToken();
      await apiBalance.withdraw(
        token: token!,
        amount: int.parse(amountWd.text),
      );
      Get.back();
      isRequestWd.value = false;
    } catch (e) {
      log("error $e");
      isRequestWd.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    handleGetMerchant();
    handleGetTrx();
  }
}
