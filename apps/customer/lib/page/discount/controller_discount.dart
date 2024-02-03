import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/discount/api_discount.dart';
import 'package:lugo_customer/response/discount.dart';

enum Status { idle, loading, success, failed }

class ControllerDiscount extends GetxController {
  final ApiDiscount api;
  ControllerDiscount({required this.api});

  var loading = Status.idle.obs;

  final FirebaseAuth firebase = FirebaseAuth.instance;

  RxList<Discount> discount = <Discount>[].obs;

  getDiscount() async {
    try {
      loading(Status.loading);
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.getDiscount(token: token!);
      if (r != null) {
        var mapper = r;
        discount(
            RxList<Discount>.from(mapper.map((e) => Discount.fromJson(e))));
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

  @override
  void onInit() {
    getDiscount();
    super.onInit();
  }
}
