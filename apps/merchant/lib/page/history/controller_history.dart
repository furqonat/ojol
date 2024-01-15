import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/history/api_history.dart';

enum Status { idle, loading, success, failed }

class ControllerHistory extends GetxController {
  final ApiHistory api;
  ControllerHistory({required this.api});

  var loading = Status.idle.obs;

  final _fbAuth = FirebaseAuth.instance;

  handleGetOrders() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await api.getOrders(token: token!);
    print(resp);
  }

  @override
  void onInit() {
    handleGetOrders();
    super.onInit();
  }
}
