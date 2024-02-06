import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rest_client/account_client.dart';

import 'api_ordersetting.dart';
import 'controller_ordersetting.dart';

class BindingOrderSetting implements Bindings {
  final dio = Dio();
  @override
  void dependencies() {
    Get.lazyPut<ControllerOrderSetting>(() => ControllerOrderSetting(
        api: ApiOrderSetting(),
        accountClient: AccountClient(dio)
    ));
  }
}
