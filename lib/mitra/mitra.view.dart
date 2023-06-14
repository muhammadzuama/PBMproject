import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:server_coba/location/user.location.dart';
import 'package:server_coba/mitra/add.mitra.dart';
import 'package:server_coba/mitra/edit.mitra.dart';
import '../auth/mitra.service.dart';

class ViewMitra extends StatefulWidget {
  const ViewMitra({Key? key}) : super(key: key);

  @override
  State<ViewMitra> createState() => _ViewMitraState();
}

class _ViewMitraState extends State<ViewMitra> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Icon(Icons.store),
            SizedBox(width: 8.0),
            Text('Daftar Mitra'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // String searchText = searchController.text;
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddMitra()),
              );
            },
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            child: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyLocation()),
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
            String product = mitraData['product'].toString();
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
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            namaMitra,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 14.0),
                              const SizedBox(width: 2.0),
                              Text(
                                alamatMitra,
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 14.0),
                              const SizedBox(width: 2.0),
                              Text(
                                jamBuka,
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(Icons.coffee_maker, size: 14.0),
                              const SizedBox(width: 2.0),
                              Text(
                                product,
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Hapus Mitra'),
                              content: const Text(
                                'Apakah Anda yakin ingin menghapus mitra ini?',
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('Batal'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: const Text('Hapus'),
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
