import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/dana/api_dana.dart';
import 'package:lugo_marchant/page/dana/controller_dana.dart';
import 'package:rest_client/gate_client.dart';

class BindingDana implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ControllerDana>(
      () => ControllerDana(
        api: ApiDana(
          gateClient: GateClient(dio),
        ),
      ),
    );
  }
}
