import 'dart:developer';

import 'package:get/get.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ControllerWebView extends GetxController {
  late WebViewController webViewController;

  @override
  void onInit() {
    var url = Get.arguments;

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (change) async {
          log("link apa => ${change.url}");
          var checker = change.url!.contains('responseMessage=Successful');
          if (checker == true) {
            Get.offAllNamed(Routes.saldo);
          } else {
            log('${change.url}');
          }
        },
      ));
    super.onInit();
  }
}
