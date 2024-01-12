import 'package:get/get.dart';
import 'package:lugo_customer/page/mart_order_history/api_marthistory.dart';
import 'package:lugo_customer/page/mart_order_history/controller_marthistory.dart';

class BindingMartHistory implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerMartHistory>(() => ControllerMartHistory(api: ApiMartHistory()));
  }
}