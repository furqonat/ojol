import 'package:get/get.dart';
import 'package:lugo_customer/page/mart_pay/api_marpay.dart';

class ControllerMartPay extends GetxController {
  final ApiMartPay api;
  ControllerMartPay({required this.api});

  var categoryTypeList = [
    "Pembayaran",
    "Cash",
    "Dana",
  ].obs;

  var categoryType = "Pembayaran".obs;
}
