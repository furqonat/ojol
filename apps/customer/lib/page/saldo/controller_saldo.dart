import 'package:get/get.dart';
import 'package:lugo_customer/page/saldo/api_saldo.dart';

class ControllerSaldo extends GetxController {
  final ApiSaldo api;
  ControllerSaldo({required this.api});

  var orderList = [
    "Hari ini",
    "Minggu ini",
    "Bulan ini",
  ].obs;

  var orderValue = "Hari ini".obs;
}
