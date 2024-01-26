import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<dynamic> FirestorePost(
      String collection, Map<String, dynamic> params) async {
    final r = FirebaseFirestore.instance.collection(collection).doc();
    await r.set(params);
    return r.id;
  }

  Stream<List<T>> firestoreStreamGet<T>(String collection,
      {T Function(Map<String, dynamic> data)? fromJson}) {
    return FirebaseFirestore.instance.collection(collection).snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map<T>((doc) => fromJson?.call(doc.data()) as T ?? doc.data() as T)
            .toList());
  }
}
