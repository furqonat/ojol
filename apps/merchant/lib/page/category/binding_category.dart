import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/category/api_category.dart';
import 'package:lugo_marchant/page/category/controller_category.dart';
import 'package:rest_client/product_client.dart';

class BindingCategory implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerCategory>(
      () => ControllerCategory(
        api: ApiCategory(
          productClient: ProductClient(dio),
        ),
      ),
    );
  }
}
