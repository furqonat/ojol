import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:lugo_customer/api/local_service.dart';
import 'package:lugo_customer/page/main_page/api_main.dart';
import 'package:lugo_customer/response/banner.dart';
import 'package:lugo_customer/response/product.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:lugo_customer/shared/controller/controller_user.dart';

class ControllerMain extends GetxController {
  final ApiMain api;
  ControllerMain({required this.api});

  var orderType = ''.obs;
  var trxId = ''.obs;
  var price = 0.obs;

  var listImg = [
    'assets/images/2023-05-12_(1).jpg',
    'assets/images/2023-05-05.jpg',
    'assets/images/2023-05-12_(2).jpg'
  ];

  var secondListImg = [
    'assets/images/2023-05-12_(2).jpg',
    'assets/images/2023-05-05.jpg',
    'assets/images/2023-05-12_(1).jpg'
  ];

  var loading = false.obs;

  var productLoading = false.obs;

  RxList<Banners> banner = <Banners>[].obs;

  final Location location = Location();

  final firebase = FirebaseAuth.instance;

  Rx<LocationData> myLocation = LocationData.fromMap({
    "latitude": 0.0,
    "longitude": 0.0,
  }).obs;

  ControllerUser controllerUser = Get.find<ControllerUser>();

  var orderLimit = false.obs;

  RxList<Product> product = <Product>[].obs;

  @override
  void onInit() async {
    safeDeviceToken();
    locationServicePermission();
    getBanner();
    getRecommendProduct();
    safeDeviceToken();

    orderType.value = await LocalService().getRequestType() ?? "";
    trxId.value = await LocalService().getTransactionId() ?? "";
    price.value = await LocalService().getPrice() ?? 0;

    if (orderType.value != "" && trxId.value != "" && price.value != 0) {
      orderLimit.value = true;
    } else {
      orderLimit.value = false;
    }

    super.onInit();
  }

  safeDeviceToken() async {
    try {
      var token = await FirebaseAuth.instance.currentUser?.getIdToken();
      var tokenDevice = await LocalService().getTokenDevice();
      await api.safeDeviceToken(deviceToken: tokenDevice!, token: token!);
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
    }
  }

  locationServicePermission() async {
    var permission = await location.hasPermission();
    var service = await location.serviceEnabled();
    if (permission != PermissionStatus.granted ||
        permission != PermissionStatus.grantedLimited) {
      await location.requestPermission();
    }
    if (!service) {
      await location.requestService();
    }

    await location
        .getLocation()
        .then((value) => myLocation.value = LocationData.fromMap({
              "latitude": value.latitude,
              "longitude": value.longitude,
            }));
  }

  onProgress(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content:
            const Image(image: AssetImage('assets/images/coming_soon.jpg')),
      ),
    );
  }

  getBanner() async {
    try {
      loading(true);
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.getBanner(token: token!);
      if (r != null) {
        var list = r;
        banner(RxList<Banners>.from(list.map((e) => Banners.fromJson(e)) ?? []));
        loading(false);
      } else {
        Fluttertoast.showToast(msg: "Ada yang salah");
        loading(false);
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
      loading(false);
    }
  }

  checkorder() async {
    if (orderType.value != "" && trxId.value != "" && price.value != 0) {
      Get.offNamed(Routes.checkOrder, arguments: {
        "request_type": orderType.value,
        "order_id": trxId.value,
        "price": price.value,
        "latitude": myLocation.value.latitude,
        "longitude": myLocation.value.longitude,
      });
    } else {
      Fluttertoast.showToast(
          msg: "Anda tidak punya pesanan yang sedang berjalanan");
    }
  }

  getRecommendProduct() async {
    try {
      productLoading(true);
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.getRecomendedProduct(token: token!);
      if (r["total"] != 0) {
        var list = r["data"];
        product(RxList<Product>.from(list.map((e) => Product.fromJson(e))));
      }
      productLoading(false);
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
      productLoading(false);
    }
  }
}
