import 'package:flutter/material.dart';
import 'package:server_coba/utils/global.color.dart';

class CariMitra extends StatefulWidget {
  const CariMitra({super.key});

  @override
  State<CariMitra> createState() => _CariMitraState();
}

class _CariMitraState extends State<CariMitra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColors.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: GlobalColors.button,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: GlobalColors.background,
            ),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: GlobalColors.button, // atur warna stroke di sini
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Cari Produsen Kopi",
                hintStyle: TextStyle(
                  fontSize: 15,
                  color:
                      const Color.fromARGB(255, 104, 103, 103).withOpacity(0.6),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ));
  }
}
