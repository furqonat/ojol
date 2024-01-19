import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rest_client/shared.dart';
import 'package:rest_client/transaction_client.dart';

class ControllerHistoryOrder extends GetxController {
  ControllerHistoryOrder({required this.transactionClient});

  final TransactionClient transactionClient;
  final _fbAuth = FirebaseAuth.instance;

  final isLoading = false.obs;
  final transactions = <Transaction>[].obs;

  handleGetTransactions() async {
    isLoading.value = true;
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await transactionClient.getDriverTransactions(
        bearerToken: "Bearer $token");
    transactions.value = resp;
    isLoading.value = false;
  }
}
