import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/digital_pay/controller_digitalpay.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageDigitalPay extends GetView<ControllerDigitalPay> {
  const PageDigitalPay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Expanded(
            child: WebViewWidget(controller: controller.webViewController),
          )),
    );
  }
}
