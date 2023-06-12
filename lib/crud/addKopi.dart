import 'package:flutter/material.dart';
import 'package:server_coba/auth/kopi.services.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _controllerNamaKopi = TextEditingController();
  TextEditingController _controllerJumlah = TextEditingController();

  @override
  void dispose() {
    _controllerNamaKopi.dispose();
    _controllerJumlah.dispose();
    super.dispose();
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
            ElevatedButton(
              onPressed: () {
                KopiService.insert(
                  nama_kopi: _controllerNamaKopi.text,
                  jumlah: _controllerJumlah.text,
                ).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Data berhasil ditambahkan"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                });
              },
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
