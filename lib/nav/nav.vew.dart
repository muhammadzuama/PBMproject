import 'package:flutter/material.dart';
import 'package:server_coba/profile/control.profile.dart';
import 'package:server_coba/utils/global.color.dart';
import 'package:server_coba/view/cari.view.dart';
import 'package:server_coba/view/favorit.view.dart';
import 'package:server_coba/view/home.view.dart';
import 'package:server_coba/view/profile.view.dart';

/// Flutter code sample for [BottomNavigationBar].

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  final screens = [
    const Homepage(),
    const CariMitra(),
    const FavosritView(),
    const EditProfile()
    // const ProfileView(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Sample'),
      // ),
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
              backgroundColor: GlobalColors.button),
          BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: 'Cari Mitra',
              backgroundColor: GlobalColors.button),
          BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: 'Favorite',
              backgroundColor: GlobalColors.button),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'Profile',
              backgroundColor: GlobalColors.button),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}
