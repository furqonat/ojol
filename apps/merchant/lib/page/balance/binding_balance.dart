import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/balance/api_balance.dart';
import 'package:lugo_marchant/page/balance/controller_balance.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/gate_client.dart';
import 'package:rest_client/transaction_client.dart';

class BindingBalance implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut(
      () => ControllerBalance(
        apiBalance: ApiBalance(
          accountClient: AccountClient(dio),
          gateClient: GateClient(dio),
          trxClient: TransactionClient(dio),
        ),
      ),
    );
  }
}
