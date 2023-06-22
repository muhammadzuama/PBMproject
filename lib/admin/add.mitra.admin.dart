import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/mitra.service.dart';

class AddMitraAdmin extends StatefulWidget {
  const AddMitraAdmin({Key? key}) : super(key: key);

  @override
  State<AddMitraAdmin> createState() => _AddMitraState();
}

class _AddMitraState extends State<AddMitraAdmin> {
  File? _image;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _jamBukaController = TextEditingController();
  final TextEditingController _produkController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _jamBukaController.dispose();
    _produkController.dispose();
    _deskripsiController.dispose();
    _lokasiController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Add Mitra'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Mitra',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: 'Alamat Mitra',
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _jamBukaController,
                decoration: const InputDecoration(
                  labelText: 'Jam Buka',
                  prefixIcon: Icon(Icons.access_time),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _produkController,
                decoration: const InputDecoration(
                  labelText: 'Produk yang Dijual',
                  prefixIcon: Icon(Icons.shopping_cart),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _lokasiController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Lokasi (Latitude, Longitude)',
                  prefixIcon: Icon(Icons.location_pin),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _noHpController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Ambil Foto'),
                    style: ElevatedButton.styleFrom(primary: Colors.brown),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _pickImageFromGallery(),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Ambil dari Galeri'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                  ),
                ],
              ),
              if (_image != null) ...[
                const SizedBox(height: 16.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(
                    _image!,
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String namaMitra = _namaController.text;
                  String alamatMitra = _alamatController.text;
                  String jamBuka = _jamBukaController.text;
                  String produk = _produkController.text;
                  String deskripsi = _deskripsiController.text;
                  String lokasi = _lokasiController.text;
                  String noHp = _noHpController.text;

                  if (_image != null) {
                    String imagePath = _image!.path;
                    List<String> lokasiSplit = lokasi.split(",");

                    try {
                      double latitude = double.parse(lokasiSplit[0]);
                      double longitude = double.parse(lokasiSplit[1]);

                      await MitraService.insert(
                        nama_toko: namaMitra,
                        description: deskripsi,
                        no_hp: noHp,
                        alamat: alamatMitra,
                        gambarPath: imagePath,
                        product: produk,
                        jam_buka: jamBuka,
                        location: GeoPoint(latitude, longitude),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Data berhasil ditambahkan"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                                'Latitude dan Longitude harus berupa angka'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Pilih gambar terlebih dahulu'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
