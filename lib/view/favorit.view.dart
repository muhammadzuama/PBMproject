import 'package:flutter/material.dart';

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
    );
  }
}
