import 'package:get/get.dart';
import 'package:lugo_driver/page/dashboard/api_dashboard.dart';
import 'controller_dashboard.dart';

class BindingDashboard implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerDashboard>(
        () => ControllerDashboard(api: ApiDashboard()));
  }
}
