import 'dart:developer';

import 'package:lugo_customer/api/api_service.dart';
import 'package:lugo_customer/shared/query_builder.dart';

class ApiEditProfile {
  Future<dynamic> editUser({
    String? name,
    String? email,
    String? phone,
    String? avatar,
    required String token,
  }) async {
    final body = QueryBuilder()
      ..addQuery("name", name)
      ..addQuery("avatar", avatar)
      ..addQuery("email", email)
      ..addQuery('phoneNumber', phone);

    var r = await ApiService().apiJSONPutWithFirebaseToken(
        'account', 'customer', body.toMap(), token);

    log('input user => $body');
    log('feedback => $r');

    return r;
  }
}
