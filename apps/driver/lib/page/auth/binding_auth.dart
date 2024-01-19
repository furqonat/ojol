import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/page/auth/controller_auth.dart';
import 'package:lugo_driver/shared/preferences.dart';
import 'package:rest_client/auth_client.dart';

class BindingAuth implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    final pref = LocalStorage.instance;
    Get.lazyPut<ControllerAuth>(
      () => ControllerAuth(
        authClient: AuthClient(dio),
        preferences: Preferences(pref),
      ),
    );
  }
}
