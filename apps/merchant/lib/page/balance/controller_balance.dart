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

  handleWithdraw(Function callback) async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await apiBalance.withdraw(
      token: token!,
      amount: int.parse(amountWd.text),
    );
    if (resp['message'] == 'OK') {
      callback();
    }
  }

  @override
  void onInit() {
    super.onInit();
    handleGetMerchant();
    handleGetTrx();
  }
}
