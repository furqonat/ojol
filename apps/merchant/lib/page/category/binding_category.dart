import 'package:get/get.dart';
import 'package:lugo_marchant/page/category/api_category.dart';
import 'package:lugo_marchant/page/category/controller_category.dart';

class BindingCategory implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerCategory>(() => ControllerCategory(api: ApiCategory()));
  }
}