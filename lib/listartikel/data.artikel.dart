import 'package:flutter/material.dart';
import 'package:server_coba/listartikel/detail.vew.dart';
import 'package:server_coba/listartikel/list.artikel.dart';
import 'package:server_coba/utils/global.color.dart';

// ignore: must_be_immutable
class NewlistArtikel extends StatefulWidget {
  NewlistArtikel(this.data, {Key? key}) : super(key: key);
  Artikel data;
  @override
  State<NewlistArtikel> createState() => _NewlistArtikelState();
}

class _NewlistArtikelState extends State<NewlistArtikel> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailArtikel(widget.data)));
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(12),
        height: 112,
        decoration: BoxDecoration(
            color: GlobalColors.button,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.data.urlImage!),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
                flex: 5,
                child: Column(
                  children: [
                    Text(
                      widget.data.title!,
                      style: TextStyle(
                          color: GlobalColors.background,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.data.penulis!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: GlobalColors.splashscreen),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
