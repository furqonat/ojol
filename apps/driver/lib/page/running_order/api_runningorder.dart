import 'package:lugo_driver/api/api_service.dart';

class ApiRunningOrder{
  Future<dynamic>listOrder(String token)async{
    var r = await ApiService().apiJSONGetWitFirebaseToken('order', 'driver', token);
    return r;
  }
}