import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MyCollection {
  MyCollection._();
  static CollectionReference kopies =
      FirebaseFirestore.instance.collection("kopi");
}

class KopiService {
  static Future<QuerySnapshot<Object?>> getAll() async {
    return await MyCollection.kopies.get();
  }

  static Future<String> _uploadImage(File imageFile) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('gambar')
        .child(DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  static Future<DocumentReference<Object?>> insert({
    required String nama_kopi,
    required String jumlah,
    required File gambarFile,
  }) async {
    String gambarURL = await _uploadImage(gambarFile);
    return await MyCollection.kopies.add({
      "nama_kopi": nama_kopi,
      "jumlah": jumlah,
      "gambarURL": gambarURL,
    });
  }

  static Future<void> delete({
    required String kopiId,
  }) async {
    return await MyCollection.kopies.doc(kopiId).delete();
  }

  static Future<void> update({
    required String kopiId,
    required String nama_kopi,
    required String jumlah,
  }) async {
    return await MyCollection.kopies.doc(kopiId).update({
      "nama_kopi": nama_kopi,
      "jumlah": jumlah,
    });
  }

  static Future<DocumentSnapshot<Object?>> getDataById(String kopiId) async {
    return await MyCollection.kopies.doc(kopiId).get();
  }
}
