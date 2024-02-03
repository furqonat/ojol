import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/history_order/api_history.dart';
import 'package:lugo_customer/response/order_history.dart';

enum Status { idle, loading, success, failed }

class ControllerHistory extends GetxController {
  final ApiHistory api;
  ControllerHistory({required this.api});

  var loading = Status.idle.obs;

  final firebase = FirebaseAuth.instance;

  RxList<OrderHistory> orders = <OrderHistory>[].obs;
  RxList<OrderHistory> ordersByDate = <OrderHistory>[].obs;

  Rx<DateTime> filterDate = DateTime.now().obs;

  @override
  void onInit() {
    getHistory();
    super.onInit();
  }

  getHistory() async {
    try {
      var token = await firebase.currentUser?.getIdToken();
      loading(Status.loading);
      var r = await api.getHistoryOrder(token!);
      if (r["total"] != 0) {
        var list = r['data'];
        orders(RxList<OrderHistory>.from(
            list.map((e) => OrderHistory.fromJson(e))));
        loading(Status.success);
      } else {
        loading(Status.failed);
      }
    } catch (e, stackTrace) {
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
      filterDate.value = DateTime.parse(selectedDate.toIso8601String());

      if (filterDate.value != DateTime.now()) {
        filterDate.value = filterDate.value;
      }

      for (var order in orders) {
        DateTime orderDate = DateTime.parse(order.createdAt.toString());
        DateTime orderDateOnly =
            DateTime(orderDate.year, orderDate.month, orderDate.day);
        if (orderDateOnly
            .isAtSameMomentAs(DateTime.parse(filterDate.value.toString()))) {
          ordersByDate.add(order);
        }
      }
    }
  }
}
