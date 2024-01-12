import 'package:get/get.dart';
import 'package:lugo_marchant/page/history/api_history.dart';

enum Status { idle, loading, success, failed }

class ControllerHistory extends GetxController{
  final ApiHistory api;
  ControllerHistory({required this.api});

  var loading = Status.idle.obs;
}