import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/page/wallet/controller_wallet.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/gate_client.dart';
import 'package:rest_client/transaction_client.dart';

class BindingWallet implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();

    Get.lazyPut<ControllerWallet>(
      () => ControllerWallet(
        gateClient: GateClient(dio),
        trxClient: TransactionClient(dio),
        accountClient: AccountClient(dio),
      ),
    );
  }
}
