import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../auth/kopi.services.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _controllerNamaKopi = TextEditingController();
  TextEditingController _controllerJumlah = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  @override
  void dispose() {
    _controllerNamaKopi.dispose();
    _controllerJumlah.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _pickedImage = File(pickedImage.path);
      }
    });
  }

  Future<void> _uploadData() async {
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Anda belum memilih gambar"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Mengambil nilai dari text field
      String namaKopi = _controllerNamaKopi.text;
      String jumlah = _controllerJumlah.text;

      // Memanggil fungsi insert untuk menyimpan data ke server
      await KopiService.insert(
        nama_kopi: namaKopi,
        jumlah: jumlah,
        gambarFile: _pickedImage!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Data berhasil ditambahkan"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Kopi Page"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Jenis Kopi",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controllerNamaKopi,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan Jenis Kopi',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Jumlah",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controllerJumlah,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan Jumlah',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              style: ElevatedButton.styleFrom(
                primary:
                    Colors.brown, // Ubah warna latar belakang menjadi coklat
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              icon: Icon(Icons.photo_library), // Tambahkan ikon dari galeri
              label: const Text(
                'Pilih Gambar dari Galeri',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              style: ElevatedButton.styleFrom(
                primary:
                    Colors.brown, // Ubah warna latar belakang menjadi coklat
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              icon: Icon(Icons.camera_alt), // Tambahkan ikon dari kamera
              label: const Text(
                'Ambil Gambar dari Kamera',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            if (_pickedImage != null) Image.file(_pickedImage!),
            ElevatedButton(
              onPressed: _uploadData,
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                'Tambah Data',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
