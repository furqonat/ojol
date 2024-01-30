import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/auth/controller_auth.dart';
import 'package:rest_client/auth_client.dart';

class BindingAuth implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerAuth>(
      () => ControllerAuth(
        authClient: AuthClient(dio),
      ),
    );
  }
}
