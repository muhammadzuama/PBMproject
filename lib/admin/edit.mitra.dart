import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditMitraAdmin extends StatefulWidget {
  final String mitraId;
  final String namaToko;
  final String gambar;
  final String description;
  final String noHp;
  final String alamat;
  final String jamBuka;
  final GeoPoint location;
  final String product;

  const EditMitraAdmin({
    Key? key,
    required this.mitraId,
    required this.namaToko,
    required this.gambar,
    required this.description,
    required this.noHp,
    required this.alamat,
    required this.jamBuka,
    required this.location,
    required this.product,
    required String longitude,
    required String latitude,
    required String waktu,
  }) : super(key: key);

  @override
  State<EditMitraAdmin> createState() => _EditMitraState();
}

class _EditMitraState extends State<EditMitraAdmin> {
  late Stream<DocumentSnapshot> mitraStream;

  @override
  void initState() {
    super.initState();
    mitraStream = FirebaseFirestore.instance
        .collection('mitra')
        .doc(widget.mitraId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Edit Mitra'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: mitraStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Text('Data not found');
          }

          var mitraData = snapshot.data!.data() as Map<String, dynamic>;
          String namaToko = mitraData['nama_toko'] ?? '';
          String gambar = mitraData['gambar'] ?? '';
          String description = mitraData['description'] ?? '';
          String noHp = mitraData['no_hp'] ?? '';
          String alamat = mitraData['alamat'] ?? '';
          String product = mitraData['product'] ?? '';
          String jamBuka = mitraData['jam_buka'] ?? '';
          GeoPoint location = mitraData['location'] ?? const GeoPoint(0, 0);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nama Toko:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(namaToko),
                const SizedBox(height: 8.0),
                Image.network(
                  gambar,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.0,
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Deskripsi:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(description),
                const SizedBox(height: 8.0),
                const Text(
                  'No. HP:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Text(noHp),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Alamat:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(alamat),
                const SizedBox(height: 8.0),
                const Text(
                  'Product:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(product),
                const SizedBox(height: 8.0),
                const Text(
                  'Jam Buka:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Text(jamBuka),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Lokasi:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Latitude: ${location.latitude}'),
                Text('Longitude: ${location.longitude}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
