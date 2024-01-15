import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/dana/api_dana.dart';
import 'package:rest_client/shared.dart';

class ControllerDana extends GetxController {
  ControllerDana({required this.api});

  final ApiDana api;
  final _fbAuth = FirebaseAuth.instance;
  final transaction = <Transaction>[].obs;
  final orderList = [
    "Bulan Ini",
    "Minggu Ini",
    "Hari Ini",
  ].obs;

  final orderValue = "Bulan Ini".obs;
  final phoneNumber = ''.obs;
  final balance = 0.obs;

  handleGetDanaProfile() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.getDanaProfile(token: token!);
    final b = resp.where((element) => element.resourceType == 'BALANCE').first;
    balance.value = int.parse(b.value);
    final phone = resp
        .where(
          (element) => element.resourceType == 'MASK_DANA_ID',
        )
        .first;
    phoneNumber.value = phone.value;
  }

  handleGetTrx([trxIn = "day"]) async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.getMerchantTransactions(
      token: token!,
      trxIn: trxIn,
    );
    transaction.value = resp;
  }

  @override
  void onInit() {
    handleGetTrx();
    handleGetDanaProfile();
    super.onInit();
  }
}
