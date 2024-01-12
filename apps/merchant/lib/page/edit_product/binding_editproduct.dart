import 'package:get/get.dart';
import 'package:lugo_marchant/page/edit_product/api_editproduct.dart';
import 'package:lugo_marchant/page/edit_product/controller_editproduct.dart';

class BindingEditProduct extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerEditProduct>(() => ControllerEditProduct(api: ApiEditProduct()));
  }
}