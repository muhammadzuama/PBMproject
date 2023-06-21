// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

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
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    mitraStream = FirebaseFirestore.instance
        .collection('mitra')
        .doc(widget.mitraId)
        .snapshots();
  }

  void zoomIn() {
    mapController.move(mapController.center, mapController.zoom + 1);
  }

  void zoomOut() {
    mapController.move(mapController.center, mapController.zoom - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Mitra'),
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
            child: SingleChildScrollView(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.brown,
                        ),
                        icon: const Icon(
                          Icons.alarm,
                          color: Colors.white,
                        ),
                        label: Text(
                          jamBuka,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          String modifiedNoHp = noHp;
                          if (noHp.startsWith('0')) {
                            modifiedNoHp = '62${noHp.substring(1)}';
                          }

                          // Validasi nomor telepon hanya terdiri dari angka
                          if (modifiedNoHp.contains(RegExp(r'^[0-9]+$'))) {
                            final url = 'https://wa.me/$modifiedNoHp';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          } else {
                            throw 'Invalid phone number format';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.brown,
                        ),
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        label: Text(
                          noHp,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Deskripsi:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(description),
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
                    'Lokasi:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 200,
                    child: FlutterMap(
                      mapController: mapController,
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
                              width: 100.0,
                              height: 100.0,
                              point: LatLng(
                                location.latitude,
                                location.longitude,
                              ),
                              builder: (ctx) => const Icon(
                                Icons.place,
                                color: Colors.brown,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.zoom_in),
                        onPressed: zoomIn,
                      ),
                      IconButton(
                        icon: const Icon(Icons.zoom_out),
                        onPressed: zoomOut,
                      ),
                    ],
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
