import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lugo_driver/shared/preferences.dart';
import 'package:rest_client/account_client.dart';
import 'api_form.dart';
import 'controller_form.dart';

class BindingFormJoin implements Bindings {
  @override
  void dependencies() {
    final preferences = GetStorage();
    final dio = Dio();
    Get.lazyPut<ControllerFormJoin>(
      () => ControllerFormJoin(
        api: ApiFormJoin(),
        preferences: Preferences(preferences),
        accountClient: AccountClient(dio),
      ),
    );
  }
}
