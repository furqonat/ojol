import 'package:get/get.dart';

import 'api_orderfinish.dart';
import 'controller_orderfinish.dart';

class BindingOrderFinish implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerOrderFinish>(
        () => ControllerOrderFinish(api: ApiOrderFinish()));
  }
}
