import 'package:flutter/material.dart';
import 'package:server_coba/favorit/dataFavorit.dart';
import 'package:server_coba/favorit/listfavorite.dart';

import 'package:server_coba/utils/global.color.dart';

class FavosritView extends StatefulWidget {
  const FavosritView({super.key});

  @override
  State<FavosritView> createState() => _FavosritViewState();
}

class _FavosritViewState extends State<FavosritView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColors.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: GlobalColors.button,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Daftar Favorit",
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
                      children: Favorit.DataFavorit.map((e) => DetailFavorit(e))
                          .toList(),
                    )
                  ])),
        ));
  }
}
