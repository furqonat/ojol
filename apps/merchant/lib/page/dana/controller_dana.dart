import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/dana/api_dana.dart';

class ControllerDana extends GetxController {
  ControllerDana({required this.api});

  final ApiDana api;
  final _fbAuth = FirebaseAuth.instance;

  final orderList = [
    "Hari ini",
    "Minggu ini",
    "Bulan ini",
  ].obs;

  final orderValue = "Hari ini".obs;
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

  @override
  void onInit() {
    handleGetDanaProfile();
    super.onInit();
  }
}
