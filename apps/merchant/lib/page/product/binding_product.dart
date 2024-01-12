import 'package:get/get.dart';
import 'package:lugo_marchant/page/product/api_product.dart';
import 'package:lugo_marchant/page/product/controller_product.dart';

class BindingProduct implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerProduct>(() => ControllerProduct(api: ApiProduct()));
  }
}