import 'package:get/get.dart';
import 'package:lugo_customer/page/delivery_finish/api_delivfinish.dart';
import 'package:lugo_customer/page/delivery_finish/controller_delivfinish.dart';

class BindingDelivFinish implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerDelivFinish>(() => ControllerDelivFinish(api: ApiDelivFinish()));
  }
}