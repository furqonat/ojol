import 'package:lugo_driver/api/api_service.dart';

class ApiFormJoin{

  Future<dynamic> joinLugo({
    required String address,
    required String license_image,
    required String id_card_image,
    required String vehicle_type,
    required String vehicle_brand,
    required int vehicle_year,
    required String vehicle_image,
    required String vehicle_registration,
    required String vehicle_rn,
    required String referal,
    required String token,
  })async{

    final body = {
      "details": {
        "address": address,
        "license_image": license_image,
        "id_card_image": id_card_image,
        "vehicle": {
          "create": {
            "vehicle_type": vehicle_type, // BIKE or CAR,
            "vehicle_brand": vehicle_brand,
            "vehicle_year": vehicle_year,
            "vehicle_image": vehicle_image,
            "vehicle_registration": vehicle_registration, // FOTO stnk
            "vehicle_rn": vehicle_rn // plat nomor
          }
        }
      },
      "referal": referal
    };

    var r = await ApiService().apiJSONPostWithFirebaseToken('account/driver', body, token);
    return r;
  }

  Future<dynamic> sendToken ({
    required String sample,
    required String token,
  })async{

    final body = {
      "sample" : sample
    };

    var r = await ApiService().apiJSONPostWithFirebaseToken('auth/driver', body, token);
    return r;
  }

}