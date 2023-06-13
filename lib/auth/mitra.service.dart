import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MitraCollection {
  MitraCollection._();
  static CollectionReference mitra =
      FirebaseFirestore.instance.collection("mitra");
}

class MitraService {
  static Future<QuerySnapshot<Object?>> getAll() async {
    return await MitraCollection.mitra.get();
  }

  static Future delete({
    required String mitraId,
  }) async {
    return await MitraCollection.mitra.doc(mitraId).delete();
  }

  static Future<void> insert({
    required String nama_toko,
    required String description,
    required String no_hp,
    required String alamat,
    required String gambarPath,
    required String product,
    required String jam_buka,
    required GeoPoint location,
  }) async {
    String gambarURL = await _uploadImage(gambarPath);
    await MitraCollection.mitra.add({
      "nama_toko": nama_toko,
      "description": description,
      "no_hp": no_hp,
      "alamat": alamat,
      "gambar": gambarURL,
      "product": product,
      "jam_buka": jam_buka,
      "location": location,
    });
  }

  static Future<String> _uploadImage(String imagePath) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('gambar')
        .child(DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(imagePath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
