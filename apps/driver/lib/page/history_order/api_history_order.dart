import '../../api/api_service.dart';

class ApiHistoryOrder{
  Future<dynamic> getOrderHistory({required String token})async=>
      await ApiService().apiJSONGetWitFirebaseToken("order", 'driver/history', token);
}
