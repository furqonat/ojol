import 'package:get/get.dart';
import 'package:lugo_driver/shared/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller_auth.dart';
import 'package:rest_client/auth_client.dart';
import 'package:dio/dio.dart';

class BindingAuth implements Bindings {
  @override
  void dependencies() async {
    final dio = Dio();
    final preferences = await SharedPreferences.getInstance();
    Get.lazyPut<ControllerAuth>(
      () => ControllerAuth(
        authClient: AuthClient(dio),
        preferences: Preferences(preferences),
      ),
    );
  }
}
