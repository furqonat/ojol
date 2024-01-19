import 'package:get/get.dart';

import 'api_ordersetting.dart';
import 'controller_ordersetting.dart';

class BindingOrderSetting implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerOrderSetting>(
        () => ControllerOrderSetting(api: ApiOrderSetting()));
  }
}
