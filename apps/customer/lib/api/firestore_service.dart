import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{

  Future<dynamic> FirestorePost (String collection, String documents, Map<String, dynamic> params) async {
    final r = FirebaseFirestore.instance.collection(collection).doc(documents);
    await r.set(params);
  }

  Stream<String> FirestoreStreamGet(String collection) {
    final r = FirebaseFirestore.instance.collection(collection).snapshots();

    return r.map((QuerySnapshot querySnapshot) {
      final List<Map<String, dynamic>> dataList = [];

      for (var doc in querySnapshot.docs) {
        final Map<String, dynamic> dataMap = doc.data() as Map<String, dynamic>;
        dataList.add(dataMap);
      }

      return json.encode(dataList);

    });
  }

}