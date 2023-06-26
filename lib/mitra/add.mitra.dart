import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/mitra.service.dart';

class AddMitra extends StatefulWidget {
  const AddMitra({Key? key}) : super(key: key);

  @override
  State<AddMitra> createState() => _AddMitraState();
}

class _AddMitraState extends State<AddMitra> {
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
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: 'Alamat Mitra',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _jamBukaController,
                decoration: const InputDecoration(
                  labelText: 'Jam Buka',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _produkController,
                decoration: const InputDecoration(
                  labelText: 'Produk yang Dijual',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _lokasiController,
                decoration: const InputDecoration(
                  labelText: 'Lokasi (Latitude, Longitude)',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _noHpController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: const Text('Ambil Foto'),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickImageFromGallery(),
                    child: const Text('Ambil dari Galeri'),
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

                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Data berhasil ditambahkan"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } else {
                    // Handling jika gambar belum dipilih
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Pilih gambar terlebih dahulu"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
