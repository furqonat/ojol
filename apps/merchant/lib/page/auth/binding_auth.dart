import 'package:lugo_marchant/page/auth/api_auth.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/auth_client.dart';
import 'package:dio/dio.dart' show Dio;

import 'package:get/get.dart';
import 'controller_auth.dart';

class BindingAuth implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerAuth>(
      () => ControllerAuth(
        api: ApiAuth(
          accountClient: AccountClient(dio),
          authClient: AuthClient(dio),
        ),
      ),
    );
  }
}
