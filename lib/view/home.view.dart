import 'package:flutter/material.dart';
import 'package:server_coba/listartikel/data.artikel.dart';
import 'package:server_coba/listartikel/list.artikel.dart';
import 'package:server_coba/utils/global.color.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: GlobalColors.background,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello Admin Kafe",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 137,
                      decoration: BoxDecoration(
                        color: GlobalColors
                            .button, // Ubah warna rectangle sesuai kebutuhan Anda
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        readOnly: true,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                ' "Hidup ini seperti secangkir kopi di mana pahit dan manis bertemu dalam kehangatan" ',
                            hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: GlobalColors.background),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40)),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Seputar Kopi",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children:
                          Artikel.DataArtikel.map((e) => NewlistArtikel(e))
                              .toList(),
                    )
                  ])),
        ));
  }
}
