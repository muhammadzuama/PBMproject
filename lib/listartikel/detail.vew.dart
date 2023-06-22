import 'package:flutter/material.dart';

import 'package:server_coba/listartikel/list.artikel.dart';

// ignore: must_be_immutable
class DetailArtikel extends StatefulWidget {
  DetailArtikel(this.data, {Key? key}) : super(key: key);
  Artikel data;

  @override
  State<DetailArtikel> createState() => _DetailArtikelState();
}

class _DetailArtikelState extends State<DetailArtikel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0.0,
        // iconTheme: const IconThemeData(color: Colors.w),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.title!,
                style: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                widget.data.penulis!,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Hero(
                tag: "${widget.data.title}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.network(widget.data.urlImage!),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(widget.data.content!)
            ],
          ),
        ),
      ),
    );
  }
}
