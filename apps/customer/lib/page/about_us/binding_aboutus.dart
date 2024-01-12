import 'package:get/get.dart';
import 'package:lugo_customer/page/about_us/controller_aboutus.dart';

class BindingAboutUs implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerAboutUs>(() => ControllerAboutUs());
  }
}