import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.brown,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.picture_in_picture_alt_outlined)),
                  Tab(icon: Icon(Icons.contact_mail)),
                  Tab(icon: Icon(Icons.contact_mail)),
                ],
              ),
              title: const Text('About Me'),
            ),
            body: const TabBarView(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aplikasi Findfe',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Image(
                            image: AssetImage("images/LOGO.png"),
                            width: 170,
                            height: 170,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Aplikasi Findfe adalah aplikasi berbasis Mobile yang bertujuan untuk membantu kafe dalam menemukan bahan kopi dan mitra yang tepat, cepat, dan efektif. Aplikasi ini hadir untuk mengatasi permasalahan dari dua mitra kami, yaitu kafe Ozi dan Rumah Produksi Kopi di Balurejo, Kabupaten Banyuwangi. Kafe Ozi mengalami masalah saat stok kopi mentah habis dan kesulitan mendapatkan mitra baru dengan cepat.',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Fitur aplikasi Findfe:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          leading: Icon(Icons.gps_fixed),
                          title: Text('Fitur cari mitra dengan GPS'),
                        ),
                        ListTile(
                          leading: Icon(Icons.article),
                          title: Text('Fitur Artikel'),
                        ),
                        ListTile(
                          leading: Icon(Icons.production_quantity_limits),
                          title: Text('Edit data Stock'),
                        ),
                        // Tambahkan fitur lainnya sesuai kebutuhan Anda
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aplikasi Findfe',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Image(
                            image: AssetImage("images/poster.png"),
                            width: 500,
                            height: 500,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Kontak:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('081216510089'),
                        ),
                        ListTile(
                          leading: Icon(Icons.public),
                          title: Text('www.findfe.com'),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Anggota kelompok 1'),
                        SizedBox(height: 20.0),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('images/Picture1.jpg'),
                          ),
                          title: Text('Muhammad Zuama Al Amin'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('images/Picture12.jpg'),
                          ),
                          title: Text('Alvito Diwnova'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('images/Picture3.jpg'),
                          ),
                          title: Text('Galang Prasanjaya'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
