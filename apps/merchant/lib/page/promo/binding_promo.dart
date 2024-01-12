import 'package:get/get.dart';
import 'package:lugo_marchant/page/promo/api_promo.dart';
import 'package:lugo_marchant/page/promo/controller_promo.dart';

class BindingPromo extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerPromo>(() => ControllerPromo(api: ApiPromo()));
  }
}