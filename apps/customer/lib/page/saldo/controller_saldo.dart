import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/api/local_service.dart';
import 'package:lugo_customer/page/saldo/api_saldo.dart';
import 'package:lugo_customer/response/saldo.dart';
import 'package:lugo_customer/route/route_name.dart';

enum Status { idle, loading, success, failed }

class ControllerSaldo extends GetxController {
  final ApiSaldo api;
  ControllerSaldo({required this.api});

  var loading = Status.idle.obs;

  final FirebaseAuth firebase = FirebaseAuth.instance;

  var authCheck = false.obs;

  var orderList = [
    "Hari ini",
    "Minggu ini",
    "Bulan ini",
  ].obs;

  var orderValue = "Hari ini".obs;

  var phone = ''.obs;

  Rx<Saldo> saldo = Saldo().obs;

  getOauth() async {
    try {
      loading(Status.loading);
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.getOauth(token: token!);
      if (r["message"] == "OK") {
        var link = r['signInUrl'];
        authCheck(true);
        await LocalService().setIsBinding(isBinding: true);
        Get.toNamed(Routes.webview, arguments: link);
        loading(Status.success);
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
      loading(Status.failed);
    }
  }

  getSaldo() async {
    try {
      loading(Status.loading);
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.getSaldoDana(token: token!);
      if(r["message"] != "Unauthorized Exception"){
        saldo.value = Saldo.fromJson(r["amount"]);
        loading(Status.success);
      }else{
        getOauth();
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
      loading(Status.failed);
    }
  }

  @override
  void onInit() async {
    var status = await LocalService().getIsBinding();
    if (status != null) {
      authCheck.value = status;
    } else {
      authCheck.value = false;
    }

    if (authCheck.value == true) {
      getSaldo();
    } else {
      getOauth();
    }

    super.onInit();
  }
}
