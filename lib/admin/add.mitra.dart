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
        title: Text('Add Mitra'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Mitra',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat Mitra',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _jamBukaController,
                decoration: InputDecoration(
                  labelText: 'Jam Buka',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _produkController,
                decoration: InputDecoration(
                  labelText: 'Produk yang Dijual',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _lokasiController,
                decoration: InputDecoration(
                  labelText: 'Lokasi (Latitude, Longitude)',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _noHpController,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: Text('Ambil Foto'),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickImageFromGallery(),
                    child: Text('Ambil dari Galeri'),
                  ),
                ],
              ),
              if (_image != null) ...[
                SizedBox(height: 16.0),
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
              SizedBox(height: 16.0),
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

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Data berhasil ditambahkan"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    // Handling jika gambar belum dipilih
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Pilih gambar terlebih dahulu"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
