import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/operational/controller_operational.dart';
import 'package:rest_client/account_client.dart';

class BindingOperational implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerOperational>(
      () => ControllerOperational(
        accountClient: AccountClient(dio),
      ),
    );
  }
}
