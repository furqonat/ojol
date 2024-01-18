import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/shared/preferences.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/auth_client.dart';

import 'controller_phone_verification.dart';

class BindingPhoneVerification implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    final prefenrences = LocalStorage.instance;
    Get.lazyPut(
      () => ControllerPhoneVerification(
        authClient: AuthClient(dio),
        accountClient: AccountClient(dio),
        preferences: Preferences(prefenrences),
      ),
    );
  }
}
