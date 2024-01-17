import '../../api/firestore_service.dart';

class ApiChat {
  Stream<List<T>> getChat<T>(
      {required T Function(Map<String, dynamic> data) fromJson}) {
    var r =
        FirestoreService().firestoreStreamGet<T>('chat', fromJson: fromJson);
    return r;
  }

  Future<dynamic> sendChat({
    required String msg,
    required String idSender,
    required String idReceiver,
    required DateTime time,
    required String idTrx,
    required String attachment,
  }) async {
    final body = {
      "msg": msg,
      "id_sender": idSender,
      "id_receiver": idReceiver,
      "time": time,
      "id_transaksi": idTrx,
      "attachment": attachment
    };

    var r = await FirestoreService().firestorePost("chat", body);
    return r;
  }
}
