import 'package:get/get.dart';
import 'api_historyorder.dart';
import 'controller_historyorder.dart';

class BindingHistoryOrder implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerHistoryOrder>(() => ControllerHistoryOrder(api: ApiHistoryOrder()));
  }
}