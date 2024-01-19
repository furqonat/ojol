import 'package:lugo_driver/api/api_service.dart';

class ApiFormJoin {
  Future<dynamic> joinLugo(
      {required Map<String, dynamic> body, required String token}) async {
    // final body = {
    //   "details": {
    //     "driver_type": driverType,
    //     "address": address,
    //     "license_image": licenseImage,
    //     "id_card_image": idCardImage,
    //     "vehicle": {
    //       "create": {
    //         "vehicle_type": vehicleType, // BIKE or CAR,
    //         "vehicle_brand": vehicleBrand,
    //         "vehicle_year": vehicleYear,
    //         "vehicle_image": vehicleImage,
    //         "vehicle_registration": vehicleRegistration, // FOTO stnk
    //         "vehicle_rn": vehicleRn // plat nomor
    //       }
    //     }
    //   },
    //   "referal": referal,
    //   "name": name
    // };

    var r = await ApiService()
        .apiJSONPostWithFirebaseToken('account', 'driver', body, token);
    return r;
  }

  Future<dynamic> sendToken({
    required String sample,
    required String token,
  }) async {
    final body = {"sample": sample};

    var r = await ApiService()
        .apiJSONPostWithFirebaseToken('auth', 'driver', body, token);
    return r;
  }
}
