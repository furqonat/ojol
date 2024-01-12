import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/edit_product/api_editproduct.dart';
import 'package:lugo_marchant/page/edit_product/controller_editproduct.dart';
import 'package:rest_client/product_client.dart';

class BindingEditProduct extends Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerEditProduct>(
      () => ControllerEditProduct(
        api: ApiEditProduct(productClient: ProductClient(dio)),
      ),
    );
  }
}
