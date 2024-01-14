import 'dart:developer';

import 'package:lugo_customer/api/api_service.dart';

class ApiEditProfile{

  Future<dynamic> editUser({
    required String name,
    required String email,
    required String phone,
    required String avatar,
    required String token
  }) async {
    final body = {
      'name' : name,
      'avatar' : avatar,
      'email' : email,
      'phoneNumber' : phone,
    };

    var r = await ApiService().apiJSONPutWithFirebaseToken('account/customer', body, token);

    log('input user => $body');
    log('feedback => $r');

    return r;
  }

}