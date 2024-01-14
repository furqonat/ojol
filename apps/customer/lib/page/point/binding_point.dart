import 'package:get/get.dart';
import 'package:lugo_customer/page/point/api_point.dart';
import 'package:lugo_customer/page/point/controller_point.dart';

class BindingPoint implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerPoint>(() => ControllerPoint(api: ApiPoint()));
  }
}