import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:server_coba/location/user.location.dart';
import 'package:server_coba/mitra/add.mitra.dart';
import 'package:server_coba/mitra/edit.mitra.dart';
import '../auth/mitra.service.dart';

class ViewMitraAdmin extends StatefulWidget {
  const ViewMitraAdmin({Key? key}) : super(key: key);

  @override
  State<ViewMitraAdmin> createState() => _ViewMitraState();
}

class _ViewMitraState extends State<ViewMitraAdmin> {
  TextEditingController searchController = TextEditingController();
  List<QueryDocumentSnapshot> mitraList = [];

  @override
  void initState() {
    super.initState();
    fetchMitraData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchMitraData() async {
    var mitraData = await MitraService.getAll();
    setState(() {
      mitraList = mitraData.docs;
    });
  }

  static Future<void> delete({required String mitraId}) async {
    return await FirebaseFirestore.instance
        .collection('mitra')
        .doc(mitraId)
        .delete();
  }

  Future<void> deleteMitra(String mitraId) async {
    await delete(mitraId: mitraId);
    fetchMitraData();
  }

  // Future<void> viewUserLocation() async {
  //   // Get user's location
  //   var userLocation = await LocationService.getUserLocation();

  //   // Do something with the user's location
  //   print('User Location: $userLocation');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.store),
            SizedBox(width: 8.0),
            Text('Daftar Mitra'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              String searchText = searchController.text;
              // Do something with the inputted text
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddMitra()),
              );
            },
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            child: Icon(Icons.location_on),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyLocation()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: mitraList.length,
          itemBuilder: (context, index) {
            var mitraData = mitraList[index].data() as Map<String, dynamic>;
            String namaMitra = mitraData['nama_toko'].toString();
            String alamatMitra = mitraData['alamat'].toString();
            String jamBuka = mitraData['jam_buka'].toString();
            String mitraId = mitraList[index].id;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditMitra(
                      mitraId: mitraId,
                      namaToko: namaMitra,
                      gambar: mitraData['gambar'].toString(),
                      description: mitraData['description'].toString(),
                      noHp: mitraData['no_hp'].toString(),
                      alamat: alamatMitra,
                      product: mitraData['product'].toString(),
                      jamBuka: jamBuka,
                      location: mitraData['location'] as GeoPoint,
                      latitude: '',
                      longitude: '',
                      waktu: '',
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        mitraData['gambar'].toString(),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            namaMitra,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 14.0),
                              SizedBox(width: 2.0),
                              Text(
                                alamatMitra,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 14.0),
                              SizedBox(width: 2.0),
                              Text(
                                jamBuka,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Hapus Mitra'),
                              content: Text(
                                'Apakah Anda yakin ingin menghapus mitra ini?',
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Batal'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: Text('Hapus'),
                                  onPressed: () {
                                    deleteMitra(mitraId);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
