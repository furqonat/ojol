import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/order_finish/api_orderfinish.dart';
import 'package:lugo_customer/response/driver_profile.dart';

enum Status { idle, loading, success, failed }

class ControllerOrderFinish extends GetxController {
  final ApiOrderFinish api;
  ControllerOrderFinish({required this.api});

  var driverId = ''.obs;
  var transId = ''.obs;
  var orderId = ''.obs;
  var payType = ''.obs;
  var price = 0.obs;

  final firebase = FirebaseAuth.instance;

  var driver = DriverProfile().obs;

  var loading = Status.idle.obs;

  @override
  void onInit() {
    driverId(Get.arguments["id_driver"]);
    transId(Get.arguments["id_trans"]);
    orderId(Get.arguments["id_order"]);
    payType(Get.arguments["pay_type"]);
    price(Get.arguments["price"]);

    findDriverDetail();
    super.onInit();
  }

  findDriverDetail() async {
    try {
      loading(Status.loading);
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.getDriver(driverId: driverId.value, token: token!);
      if (r != null) {
        driver.value = DriverProfile.fromJson(r);
        loading(Status.success);
      } else {
        Fluttertoast.showToast(msg: "Ada yang salah");
        loading(Status.failed);
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
      loading(Status.failed);
    }
  }
}
