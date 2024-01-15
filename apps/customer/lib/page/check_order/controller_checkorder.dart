import 'package:get/get.dart';
import 'package:lugo_customer/page/check_order/api_checkorder.dart';

class ControllerCheckOrder extends GetxController {
  final ApiCheckOrder api;
  ControllerCheckOrder({required this.api});

  var requestType = ''.obs;
  var cancelStatus = true.obs;

  @override
  void onInit() {
    requestType.value = Get.arguments["request_type"];
    super.onInit();
  }
}
