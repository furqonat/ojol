import 'package:get/get.dart';
import 'package:lugo_customer/page/webview/controller_webview.dart';

class BindingWebView implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerWebView>(() => ControllerWebView());
  }
}
