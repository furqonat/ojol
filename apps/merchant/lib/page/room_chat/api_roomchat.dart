import '../../api/firestore_service.dart';

class ApiRoomChat {
  Stream<List<T>> getRoomChat<T>(
      {required T Function(Map<String, dynamic> data) fromJson}) {
    var r =
        FirestoreService().firestoreStreamGet<T>('room', fromJson: fromJson);
    return r;
  }
}
