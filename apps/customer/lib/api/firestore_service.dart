import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<dynamic> firestorePost(
      String collection, Map<String, dynamic> params) async {
    final r = FirebaseFirestore.instance.collection(collection).doc();
    await r.set(params);
    return r.id;
  }

  Future<dynamic> firestorePut(
      String collection, String document, Map<String, dynamic> params) async {
    final r = FirebaseFirestore.instance.collection(collection).doc(document);
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

  Stream<T?> firestoreSingleStreamGet<T>(String collection, String documentId,
      {T Function(Map<String, dynamic> data)? fromJson}) {
    if (documentId.isNotEmpty) {
      return FirebaseFirestore.instance
          .collection(collection)
          .doc(documentId)
          .snapshots()
          .map((documentSnapshot) =>
              fromJson?.call(documentSnapshot.data() as Map<String, dynamic>) ??
              documentSnapshot.data() as T?);
    } else {
      return const Stream.empty();
    }
  }
}
