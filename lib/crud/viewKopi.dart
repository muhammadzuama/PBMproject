import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:server_coba/crud/addKopi.dart';
import 'package:server_coba/crud/editKopi.dart';

import '../auth/kopi.services.dart';

class ViewKopi extends StatefulWidget {
  ViewKopi({Key? key}) : super(key: key);

  @override
  State<ViewKopi> createState() => _ViewKopiState();
}

class _ViewKopiState extends State<ViewKopi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddPage()),
        ).then((_) {
          setState(() {});
        }),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: MyCollection.kopies.get()
            as Future<QuerySnapshot<Map<String, dynamic>>>,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final kopies = snapshot.data?.docs;

          return ListView.builder(
            itemCount: kopies?.length ?? 0,
            itemBuilder: (_, index) {
              final kopi = kopies?[index];
              final namaKopi =
                  kopi?['nama_kopi'].toString(); // Konversi ke String
              final jumlah = kopi?['jumlah'].toString(); // Konversi ke String

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    namaKopi!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Jumlah: $jumlah',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    final kopiId = kopi?.id;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditPage(
                                kopiId: kopiId,
                                nama_kopi: namaKopi,
                                jumlah: jumlah,
                              )),
                    ).then((_) {
                      setState(() {});
                    });
                  },
                  trailing: IconButton(
                    onPressed: () {
                      // Mendapatkan ID kopi
                      final kopiId = kopi?.id;
                      // Menghapus data kopi
                      _deleteKopi(kopiId);
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _deleteKopi(String? kopiId) {
    if (kopiId != null) {
      // Memanggil fungsi untuk menghapus data kopi dengan ID
      KopiService.delete(kopiId: kopiId).then((_) {
        // Setelah data kopi dihapus, lakukan refresh tampilan
        setState(() {});
      });
    }
  }
}
