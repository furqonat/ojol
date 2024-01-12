import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/product/api_product.dart';
import 'package:lugo_marchant/page/product/controller_product.dart';
import 'package:rest_client/product_client.dart';

class BindingProduct implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerProduct>(
      () => ControllerProduct(
        api: ApiProduct(
          productClient: ProductClient(dio),
        ),
      ),
    );
  }
}
