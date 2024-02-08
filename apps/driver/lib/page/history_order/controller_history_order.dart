import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/page/history_order/api_history_order.dart';
import 'package:rest_client/shared.dart';
import 'package:rest_client/transaction_client.dart';

import '../../response/order.dart';

enum Status { idle, loading, success, failed }

class ControllerHistoryOrder extends GetxController {
  ControllerHistoryOrder({required this.transactionClient, required this.api});

  final ApiHistoryOrder api;
  final TransactionClient transactionClient;
  final _fbAuth = FirebaseAuth.instance;

  final isLoading = false.obs;
  final transactions = <Transaction>[].obs;

  var loading = Status.idle.obs;

  var pendapatan = 0.obs;

  var date = DateTime.now().obs;

  RxList<Order> order = <Order>[].obs;
  RxList<Order> ordersByDate = <Order>[].obs;

  getOrderHistory()async{
    try{
      loading(Status.loading);
      var token = await FirebaseAuth.instance.currentUser?.getIdToken();
      var r = await api.getOrderHistory(token: token!);
      if(r["total"]!=0){
        var list = r["data"];
        order(RxList<Order>.from(list.map((e) => Order.fromJson(e))));
        for(var i in order){
          pendapatan = pendapatan + i.totalAmount!;
        }
        loading(Status.success);
      }else{
        loading(Status.failed);
      }
    }catch(e, stackTrace){
      log('$e');
      log('$stackTrace');
      loading(Status.failed);
    }
  }

  searchByDate(BuildContext context) async {
    ordersByDate.clear();
    var selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      date.value = DateTime.parse(selectedDate.toIso8601String());

      if (date != DateTime.now()) {
        date.value = date.value;
      }

      for (var order in order) {
        DateTime orderDate = DateTime.parse(order.createdAt.toString());
        DateTime orderDateOnly = DateTime(orderDate.year, orderDate.month, orderDate.day);
        if (orderDateOnly.isAtSameMomentAs(DateTime.parse(date.value.toString()))) {
          ordersByDate.add(order);
        }
      }
    }
  }

  handleGetTransactions() async {
    isLoading.value = true;
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await transactionClient.getDriverTransactions(bearerToken: "Bearer $token");
    transactions.value = resp;
    isLoading.value = false;
  }

  @override
  void onInit() {
    getOrderHistory();
    super.onInit();
  }
}
