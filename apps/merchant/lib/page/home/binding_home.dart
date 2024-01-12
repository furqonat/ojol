import 'package:dio/dio.dart' show Dio;
import 'package:get/get.dart';
import 'package:lugo_marchant/page/home/api_home.dart';
import 'package:lugo_marchant/page/home/controller_home.dart';
import 'package:rest_client/account_client.dart';

class BindingHome implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerHome>(
      () => ControllerHome(
        api: ApiHome(
          accountClient: AccountClient(dio),
        ),
      ),
    );
  }
}
