import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/response/driver.dart';
import 'package:lugo_driver/shared/query_builder.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/gate_client.dart';
import 'package:rest_client/shared.dart';
import 'package:rest_client/transaction_client.dart';
import 'package:url_launcher/url_launcher.dart';

class ControllerWallet extends GetxController {
  ControllerWallet({
    required this.gateClient,
    required this.trxClient,
    required this.accountClient,
  });

  final driver = Driver().obs;
  final trx = <Transaction>[].obs;

  final amountWd = TextEditingController();
  final amountTp = TextEditingController();

  final GateClient gateClient;
  final AccountClient accountClient;
  final TransactionClient trxClient;

  final _fbAuth = FirebaseAuth.instance;

  final orderValue = "Bulan Ini".obs;
  final orderList = [
    "Bulan Ini",
    "Minggu Ini",
    "Hari Ini",
  ].obs;

  handleGetTrx([trxIn = "month"]) async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await trxClient.getDriverTransactions(
      bearerToken: "Bearer $token",
      queries: {"trxIn": trxIn},
    );
    trx.value = resp;
  }

  Future<void> handleGetDriver() async {
    final token = await _fbAuth.currentUser?.getIdToken(true);
    final query = QueryBuilder()
      ..addQuery("id", "true")
      ..addQuery("driver_wallet", "true");
    final resp = await accountClient.getDriver(
      bearerToken: "Bearer $token",
      queries: query.toMap(),
    );
    driver.value = Driver.fromJson(resp);
  }

  Future<void> handleDriverWithdraw() async {
    if (amountWd.text.isEmpty) {
      Fluttertoast.showToast(msg: "invalid amount");
      return;
    }
    if (double.tryParse(amountWd.text) == null) {
      Fluttertoast.showToast(msg: "invalid amount");
      return;
    }

    final amount = double.parse(amountWd.text);
    if (amount <= 0) {
      Fluttertoast.showToast(msg: "invalid amount");
      return;
    }

    if (amount > driver.value.wallet!.balance) {
      Fluttertoast.showToast(msg: "insufficient balance");
      return;
    }
    final token = await _fbAuth.currentUser?.getIdToken();
    if (token != null) {
      final resp = await gateClient.driverWithdraw(
        bearerToken: "Bearer $token",
        body: {
          "amount": amount.toInt(),
        },
      );
      if (resp['message'] == "OK") {
        handleGetDriver();
        handleGetTrx();
        amountWd.clear();
        Get.back();
      }
    }
  }

  Future<void> handleDriverTopUp() async {
    if (amountTp.text.isEmpty) {
      Fluttertoast.showToast(msg: "invalid amount");
      return;
    }
    if (double.tryParse(amountTp.text) == null) {
      Fluttertoast.showToast(msg: "invalid amount");
      return;
    }

    final amount = double.parse(amountTp.text);
    if (amount <= 0) {
      Fluttertoast.showToast(msg: "invalid amount");
      return;
    }

    final token = await _fbAuth.currentUser?.getIdToken();
    if (token != null) {
      final resp = await gateClient.driverTopUp(
        bearerToken: "Bearer $token",
        body: {
          "amount": amount.toInt(),
        },
      );
      if (resp['checkoutUrl'] != null) {
        if (!await launchUrl(Uri.parse(resp['checkoutUrl']))) {
          Fluttertoast.showToast(msg: "unable to launch url");
        }
      }
    }
  }

  @override
  void onReady() async {
    await handleGetDriver();
    await handleGetTrx();
    super.onReady();
  }
}
