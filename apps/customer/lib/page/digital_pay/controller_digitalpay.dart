import 'dart:developer';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ControllerDigitalPay extends GetxController {
  var checkOutUrl = ''.obs;

  late WebViewController webViewController;

  var requestType = "".obs;
  var orderId = "".obs;

  Rx<LocationData> myLocation = LocationData.fromMap({
    'latitude': 0.0,
    'longitude': 0.0,
  }).obs;

  Rx<LocationData> destinationLocation = LocationData.fromMap({
    'latitude': 0.0,
    'longitude': 0.0,
  }).obs;

  @override
  void onInit() {
    log("argument => ${Get.arguments}");

    checkOutUrl(Get.arguments["checkout_url"]);

    requestType.value = Get.arguments["request_type"];
    orderId.value = Get.arguments["order_id"];

    myLocation.value = LocationData.fromMap({
      'latitude': Get.arguments["latitude"],
      'longitude': Get.arguments["longitude"],
    });

    destinationLocation.value = LocationData.fromMap({
      'latitude': Get.arguments["dstLatitude"],
      'longitude': Get.arguments["dstLongitude"],
    });

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(checkOutUrl.value))
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (change) async {
          var r = change.url;
          log("sampe mana=> $r");

          if (change.url == 'https://api.gentatechnology.com/trx/finish') {
            Get.toNamed(Routes.checkOrder, arguments: {
              'request_type': requestType.value,
              'latitude': myLocation.value.latitude,
              'longitude': myLocation.value.longitude,
              'dstLatitude': destinationLocation.value.latitude,
              'dstLongitude': destinationLocation.value.longitude,
              'order_id': orderId.value
            });
          }
        },
      ));

    super.onInit();
  }
}
