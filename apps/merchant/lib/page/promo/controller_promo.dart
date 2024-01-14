import 'package:get/get.dart';
import 'package:lugo_marchant/page/promo/api_promo.dart';

enum Status { idle, loading, success, failed }

class ControllerPromo extends GetxController{
  final ApiPromo api;
  ControllerPromo({required this.api});

  var loading = Status.idle.obs;
}