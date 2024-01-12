import 'package:lugo_marchant/response/user.dart';
import 'package:lugo_marchant/shared/servinces/url_service.dart';

import '../../api/api_service.dart';

class ApiProfile {
  Future<UserResponse> userDetail({required String token}) async {
    final query = QueryBuilder("merchant")
      ..addQuery("id", "true")
      ..addQuery("details", "true")
      ..addQuery("avatar", "true")
      ..addQuery("email", "true");

    var r = await ApiService().apiJSONGetWitFirebaseToken(
      'account',
      query.build().toString(),
      token,
    );

    return UserResponse.fromJson(r);
  }
}
