import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:server_coba/crud/viewKopi.dart';
import 'package:server_coba/listartikel/data.artikel.dart';
import 'package:server_coba/listartikel/list.artikel.dart';
import 'package:server_coba/mitra/mitra.view.dart';
import 'package:server_coba/utils/global.color.dart';

import '../profile/control.profile.dart';

class Homepage extends StatefulWidget {
  final UserCredential userCredential;
  const Homepage({Key? key, required this.userCredential}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  late PageController _pageController;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isDarkMode
        ? Colors.white
        : Color.fromARGB(255, 121, 85, 72); // Warna ikon

    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            color: GlobalColors.background,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 40,
                          ),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Seputar Kopi",
                      style: TextStyle(
                        // color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: Artikel.dataArtikel
                          .map((e) => NewlistArtikel(e))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            // Add more pages as needed
            ViewMitra(), // Placeholder for Search page
            ViewKopi(), // Placeholder for Favorite page
            EditProfile(), // Placeholder for Profile page
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: iconColor, // Ganti warna ikon yang terpilih
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.coffee),
              label: 'Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            // Add more BottomNavigationBarItems as needed
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleTheme,
          child: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
        ),
      ),
    );
  }
}
