import 'package:get/get.dart';
import 'api_ordersetting.dart';

class ControllerOrderSetting extends GetxController {
  final ApiOrderSetting api;
  ControllerOrderSetting({required this.api});

  static String service(int index) {
    switch (index) {
      case 0:
        return 'FOOD';
      case 1:
        return 'MART';
      case 2:
        return 'DELIVERY';
      default:
        return '';
    }
  }

  final List<Map<String, dynamic>> orderSetting = List.generate(3, (i) {
    final layanan = service(i);
    return {
      'Layanan': layanan,
      'Harga': "Pilih Harga".obs,
      'Status': false.obs,
    };
  });

  var listHarga = [
    "Pilih Harga",
    "50000",
    "100000",
    "150000",
    "200000",
  ].obs;
}
