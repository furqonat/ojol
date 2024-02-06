import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/page/dashboard/controller_dashboard.dart';
import 'package:lugo_driver/page/main/controller_main.dart';
import 'package:lugo_driver/response/free_order.dart';
import 'api_runningorder.dart';

enum Status { idle, loading, success, failed }

class ControllerRunningOrder extends GetxController {
  final ApiRunningOrder api;
  ControllerRunningOrder({required this.api});

  var loading = Status.idle.obs;

  final firebase = FirebaseAuth.instance;

  RxList<FreeOrder> freeOrder = <FreeOrder>[].obs;

  var empty = ''.obs;

  ControllerMain controllerBottomNav = Get.find<ControllerMain>();
  ControllerDashboard controllerHome = Get.find<ControllerDashboard>();

  getListOrder() async {
    try {
      var token = await firebase.currentUser?.getIdToken();
      loading(Status.loading);
      var r = await api.listOrder(token!);
      if (r["total"] != 0) {
        var list = r["data"];
        freeOrder(RxList<FreeOrder>.from(list.map((e) => FreeOrder.fromJson(e))));
        loading(Status.success);
      } else if (r["total"] == 0) {
        empty("Tidak ada pesanan yang bisa di pilih");
        loading(Status.failed);
      } else {
        Fluttertoast.showToast(msg: "Ada yang salah");
        loading(Status.failed);
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
    }
  }

  @override
  void onInit() {
    getListOrder();
    super.onInit();
  }
}
