import 'package:cloud_firestore/cloud_firestore.dart';

class MyCollection {
  MyCollection._();
  static CollectionReference kopies =
      FirebaseFirestore.instance.collection("kopi");
}

class KopiService {
  static Future<QuerySnapshot<Object?>> getAll() async {
    return await MyCollection.kopies.get();
  }

  static Future insert(
      {required String nama_kopi, required String jumlah}) async {
    return await MyCollection.kopies.add({
      "nama_kopi": nama_kopi,
      "jumlah": jumlah,
    });
  }

  static Future delete({
    required String kopiId,
  }) async {
    return await MyCollection.kopies.doc(kopiId).delete();
  }

  static Future update({
    required String kopiId,
    required String nama_kopi,
    required String jumlah,
  }) async {
    return await MyCollection.kopies.doc(kopiId).update({
      "nama_kopi": nama_kopi,
      "jumlah": jumlah,
    });
  }

  static getDataById(String s) {}
}
