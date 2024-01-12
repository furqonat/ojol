import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/response/user.dart';

import 'api_home.dart';

class ControllerHome extends GetxController {
  final ApiHome api;
  ControllerHome({required this.api});
  final merchant = UserResponse().obs;
  final _fbAuth = FirebaseAuth.instance;

  Future<void> getUser() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.getMerchant(token);
    merchant.value = resp;
  }

  @override
  void onReady() {
    getUser();
    super.onReady();
  }

  var listImg = [
    'assets/images/pamflet_1.jpg',
    'assets/images/pamflet_2.jpg',
    'assets/images/pamflet_3.jpg',
  ];
}
