import 'package:get/get.dart';
import 'package:lugo_customer/page/detail_point/api_detailpoint.dart';
import 'package:lugo_customer/page/detail_point/controller_detailpoint.dart';

class BindingDetailPoint implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ControllerDetailPoint>(() => ControllerDetailPoint(api: ApiDetailPoint()));
  }
}