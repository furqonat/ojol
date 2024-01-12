import 'package:get/get.dart';
import 'package:lugo_customer/page/mart/api_mart.dart';
import 'package:lugo_customer/page/mart/controller_mart.dart';

class BindingMart implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerMart>(() => ControllerMart(api: ApiMart()));
  }
}