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
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('View Kopi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddPage()),
              ).then((_) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.brown,
      //   onPressed: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) => AddPage()),
      //   ).then((_) {
      //     setState(() {});
      //   }),
      //   child: const Icon(Icons.add),
      // ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: MyCollection.kopies.get()
            as Future<QuerySnapshot<Map<String, dynamic>>>?,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final kopies = snapshot.data?.docs;

          return ListView.builder(
            itemCount: kopies?.length ?? 0,
            itemBuilder: (_, index) {
              final kopi = kopies?[index];
              final namaKopi = kopi?.data()['nama_kopi']?.toString() ?? '';
              final jumlah = kopi?.data()['jumlah']?.toString() ?? '';
              final gambarPath = kopi?.data()['gambarURL']?.toString() ?? '';

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    gambarPath, // Use the correct variable name here
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    namaKopi,
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
                          gambar: gambarPath,
                          namaKopi: '',
                        ),
                      ),
                    ).then((_) {
                      setState(() {});
                    });
                  },
                  trailing: IconButton(
                    onPressed: () {
                      final kopiId = kopi?.id;
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
      KopiService.delete(kopiId: kopiId).then((_) {
        setState(() {});
      });
    }
  }
}
