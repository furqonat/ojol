import '../../api/api_service.dart';

class ApiAuth{
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