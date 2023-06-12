import 'package:flutter/material.dart';
import 'package:server_coba/Artikel/componen/custome.list.dart';
import 'package:server_coba/Artikel/model/articel.model.dart';
import 'package:server_coba/Artikel/service/api.service.dart';
import 'package:server_coba/utils/global.color.dart';

class Arikel extends StatefulWidget {
  const Arikel({Key? key}) : super(key: key);

  @override
  State<Arikel> createState() => _ArikelState();
}

class _ArikelState extends State<Arikel> {
  ApiService client = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Artikel"),
        backgroundColor: GlobalColors.button,
      ),
      body: FutureBuilder<List<ArticleModel>>(
        future: client.getArtikel(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ArticleModel>> snapshot) {
          if (snapshot.hasData) {
            List<ArticleModel> articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) =>
                  customListTitle(articles[index], context),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
