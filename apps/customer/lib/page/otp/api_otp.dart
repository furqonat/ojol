import '../../api/api_service.dart';

class ApiOtp{
  Future<dynamic> sendToken ({
    required String sample,
    required String token,
  })async{

    final body = {
      "sample" : sample
    };

    var r = await ApiService().apiJSONPostWithFirebaseToken('auth/customer', body, token);
    return r;
  }
}