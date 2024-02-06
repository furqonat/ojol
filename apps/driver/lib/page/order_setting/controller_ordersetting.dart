import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rest_client/account_client.dart';
import 'api_ordersetting.dart';

class ControllerOrderSetting extends GetxController {
  final ApiOrderSetting api;
  final AccountClient accountClient;
  ControllerOrderSetting({required this.api, required this.accountClient});

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

  final FirebaseAuth firebase = FirebaseAuth.instance;

  serviceSetup(
      bool foodStatus,
      int foodPrice,
      bool martStatus,
      int martPrice,
      bool delivStatus,
      int delivPrice,
      )async{
    try{
      var token = await firebase.currentUser?.getIdToken();
      await accountClient.updateDriverOrderSetting(
          bearerToken: token!,
          body: {
            'food' : foodStatus,
            'food_price' : foodPrice,
            'mart' : martStatus,
            'mart_price' : martPrice,
            'delivery' : delivStatus,
            'delivery_price' : delivPrice,
          }
      );
    }catch(e, stackTrace){
      log('$e');
      log('$stackTrace');
    }
  }
}
