import 'package:flutter/material.dart';

import 'map.service.dart';

class MyMaps extends StatelessWidget {
  const MyMaps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenStreetMap Demo'),
      ),
      body: const OpenStreetMapWidget(),
    );
  }
}
