import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lugo_driver/page/dashboard/controller_dashboard.dart';
import 'package:lugo_driver/page/main/controller_main.dart';
import 'package:lugo_driver/response/free_order.dart';
import 'package:lugo_driver/response/order.dart';
import 'package:lugo_driver/shared/preferences.dart';
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
      print('object -> $r');
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
      log('err => $e');
      log('stack => $stackTrace');
    }
  }

  orderAccept(String orderId, int index)async{
  try{
    var token = await firebase.currentUser?.getIdToken();
    var r = await api.orderAccept(orderId: orderId, token: token!);
    if(r["message"] == "OK"){
      var detail = await api.getDetailOrder(order_id: freeOrder[index].id!, token: token);
      if(detail != null){
        await detail;
        controllerHome.order.value = Order.fromJson(detail);
        controllerHome.order.refresh();
        controllerHome.markers.add(
          Marker(
              markerId: const MarkerId('Lokasi Tujuan'),
              position: LatLng(controllerHome.order.value.orderDetail!.latitude!, controllerHome.order.value.orderDetail!.longitude!)
          ),
        );
        controllerHome.setRoutes(freeOrder[index].orderDetail!.latitude, freeOrder[index].orderDetail!.longitude);
        controllerHome.initiateChat();
        controllerHome.showBottomSheet(true);
        controllerHome.autoBid(false);
        var keeper = jsonEncode(controllerHome.order.value.toJson());
        Preferences(LocalStorage.instance).setOrderStatus(false);
        Preferences(LocalStorage.instance).setOrder(keeper);
        Preferences(LocalStorage.instance).setOrderStep('STEP_1');
        controllerBottomNav.currentPage(0);
        controllerBottomNav.pageController.jumpToPage(0);
      }
    }else{
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(r["message"]))
      );
    }
  }catch(e, stackTrace){
    log('err => $e');
    log('stack => $stackTrace');
  }
}

  @override
  void onInit() {
    getListOrder();
    super.onInit();
  }
}
