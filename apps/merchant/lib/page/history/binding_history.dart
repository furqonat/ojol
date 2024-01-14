import 'package:get/get.dart';
import 'package:lugo_marchant/page/history/api_history.dart';
import 'package:lugo_marchant/page/history/controller_history.dart';

class BindingHistory implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerHistory>(() => ControllerHistory(api: ApiHistory()));
  }
}
