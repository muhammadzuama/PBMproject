import 'package:flutter/material.dart';
import 'package:server_coba/auth/kopi.services.dart';

class EditPage extends StatefulWidget {
  final String? kopiId;
  // ignore: non_constant_identifier_names
  final String? nama_kopi;
  final String? jumlah;

  const EditPage(
      {Key? key,
      this.kopiId,
      // ignore: non_constant_identifier_names
      this.nama_kopi,
      this.jumlah,
      required String namaKopi,
      required String gambar})
      : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _controllerNamaKopi;
  late TextEditingController _controllerJumlah;
  Map<String, dynamic>? _kopiData;

  @override
  void initState() {
    super.initState();
    // Fetch the existing data for editing
    if (widget.kopiId != null) {
      _fetchDataById(widget.kopiId!);
    }
    _controllerNamaKopi = TextEditingController(text: widget.nama_kopi);
    _controllerJumlah = TextEditingController(text: widget.jumlah);
  }

  Future<void> _fetchDataById(String kopiId) async {
    try {
      final data = await KopiService.getDataById(kopiId);
      if (data.exists) {
        setState(() {
          _kopiData = data.data() as Map<String, dynamic>?;
          _controllerNamaKopi.text = _kopiData?['nama_kopi'] ?? '';
          _controllerJumlah.text = _kopiData?['jumlah'] ?? '';
        });
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Edit Kopi Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Jenis Kopi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controllerNamaKopi,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan jenis kopi",
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Jumlah",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controllerJumlah,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan jumlah kopi",
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.brown, // Set the background color to brown
              ),
              onPressed: () {
                if (widget.kopiId != null) {
                  _updateData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Data berhasil diupdate"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateData() {
    final String namaKopi = _controllerNamaKopi.text;
    final String jumlah = _controllerJumlah.text;

    KopiService.update(
      kopiId: widget.kopiId!,
      nama_kopi: namaKopi,
      jumlah: jumlah,
    ).then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      print('Error updating data: $error');
      // Handle error
    });
  }
}
