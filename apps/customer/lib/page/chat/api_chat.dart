import 'package:lugo_customer/api/firestore_service.dart';

class ApiChat {
  Stream<List<T>> getChat<T>(
      {required T Function(Map<String, dynamic> data) fromJson}) {
    var r =
        FirestoreService().firestoreStreamGet<T>('chat', fromJson: fromJson);
    return r;
  }

  Future<dynamic> sendChat({
    required String msg,
    required String senderId,
    required String chatFor,
    required DateTime time,
    required String orderTransaksiId,
    required String attachment,
  }) async {
    final body = {
      "msg": msg,
      "id_sender": senderId,
      "chatFor": chatFor,
      "time": time,
      "orderTransaksiId": orderTransaksiId,
      "attachment": attachment
    };

    var r = await FirestoreService().firestorePost("chat", body);
    return r;
  }
}
