import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/shared/preferences.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/auth_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller_phone_verification.dart';

class BindingPhoneVerification implements Bindings {
  @override
  void dependencies() async {
    final dio = Dio();
    final prefenrences = await SharedPreferences.getInstance();
    Get.lazyPut(
      () => ControllerPhoneVerification(
        authClient: AuthClient(dio),
        accountClient: AccountClient(dio),
        preferences: Preferences(prefenrences),
      ),
    );
  }
}
