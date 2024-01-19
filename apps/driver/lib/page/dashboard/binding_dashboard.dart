import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lugo_driver/api/local_serivce.dart';
import 'package:lugo_driver/page/dashboard/api_dashboard.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/order_client.dart';
import 'controller_dashboard.dart';

class BindingDashboard implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerDashboard>(
      () => ControllerDashboard(
        api: ApiDashboard(),
        accountClient: AccountClient(dio),
        orderClient: OrderClient(dio),
        localService: LocalService(GetStorage()),
      ),
    );
  }
}
