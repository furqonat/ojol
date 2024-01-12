import 'package:get/get.dart';
import 'api.dart';
import 'controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerificationController(apiService: ApiService()));
  }
}
