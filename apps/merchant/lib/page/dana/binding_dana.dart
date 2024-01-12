import 'package:get/get.dart';
import 'package:lugo_marchant/page/dana/api_dana.dart';
import 'package:lugo_marchant/page/dana/controller_dana.dart';

class BindingDana implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerDana>(() => ControllerDana(api: ApiDana()));
  }
}