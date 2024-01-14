import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rest_client/account_client.dart';
import 'api.dart';
import 'controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    final Dio dio = Dio();
    Get.lazyPut(
      () => VerificationController(
        apiService: ApiService(
          accountClient: AccountClient(dio),
        ),
      ),
    );
  }
}
