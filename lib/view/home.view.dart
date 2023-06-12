import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:server_coba/crud/viewKopi.dart';
import 'package:server_coba/listartikel/data.artikel.dart';
import 'package:server_coba/listartikel/list.artikel.dart';
import 'package:server_coba/utils/global.color.dart';

import '../profile/control.profile.dart';
import 'cari.view.dart';

class Homepage extends StatefulWidget {
  final UserCredential userCredential;
  const Homepage({Key? key, required this.userCredential}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  late PageController _pageController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: GlobalColors.button,
      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello ${widget.userCredential.user!.displayName ?? ''}",
                    style: const TextStyle(
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
                      color: Colors.black,
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
          CariMitra(), // Placeholder for Search page
          ViewKopi(), // Placeholder for Favorite page
          EditProfile(), // Placeholder for Profile page
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 121, 85, 72),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Color.fromARGB(255, 121, 85, 72),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Product',
            backgroundColor: Color.fromARGB(255, 121, 85, 72),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Color.fromARGB(255, 121, 85, 72),
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
    );
  }
}
