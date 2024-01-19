import 'package:get/get.dart';
import 'package:lugo_customer/page/history_order/api_history.dart';
import 'package:lugo_customer/page/history_order/controller_history.dart';

class BindingHistory implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerHistory>(() => ControllerHistory(api: ApiHistory()));
  }
}
