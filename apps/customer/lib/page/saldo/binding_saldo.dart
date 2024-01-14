import 'package:get/get.dart';
import 'package:lugo_customer/page/saldo/api_saldo.dart';
import 'package:lugo_customer/page/saldo/controller_saldo.dart';

class BindingSaldo implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerSaldo>(() => ControllerSaldo(api: ApiSaldo()));
  }

}