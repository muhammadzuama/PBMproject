import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditMitra extends StatefulWidget {
  final String mitraId;
  final String namaToko;
  final String gambar;
  final String description;
  final String noHp;
  final String alamat;
  final String jamBuka;
  final GeoPoint location;
  final String product;

  const EditMitra({
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
    required String latitude,
    required String longitude,
  }) : super(key: key);

  @override
  State<EditMitra> createState() => _EditMitraState();
}

class _EditMitraState extends State<EditMitra> {
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
          GeoPoint location = mitraData['location'] ?? GeoPoint(0, 0);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Toko:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                  Text(
                    'Deskripsi:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(description),
                  const SizedBox(height: 8.0),
                  Text(
                    'No. HP:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(noHp),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Alamat:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(alamat),
                  const SizedBox(height: 8.0),
                  Text(
                    'Product:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(product),
                  const SizedBox(height: 8.0),
                  Text(
                    'Jam Buka:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(jamBuka),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Lokasi:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 300,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(
                          location.latitude,
                          location.longitude,
                        ),
                        zoom: 13.0,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayerOptions(
                          markers: [
                            Marker(
                              width: 40.0,
                              height: 40.0,
                              point: LatLng(
                                location.latitude,
                                location.longitude,
                              ),
                              builder: (ctx) => Container(
                                child: Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
