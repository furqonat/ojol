import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/webview/controller_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageWebView extends GetView<ControllerWebView> {
  const PageWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller.webViewController),
    );
  }
}
