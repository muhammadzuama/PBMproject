import 'dart:async';
import 'package:flutter/material.dart';
import 'package:server_coba/utils/global.color.dart';
import '../nav/nav.vew.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const BottomNavigationBarExample()),
      );
    });
    return Scaffold(
        backgroundColor: GlobalColors.splashscreen,
        body: const Center(
          child: Image(
            image: AssetImage("images/LOGO.png"),
            width: 170,
            height: 170,
          ),
        ));
  }
}
