import 'package:flutter/material.dart';
import 'package:server_coba/location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({Key? key}) : super(key: key);

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  late LocationService locationService;
  late Stream<UserLocation> locationStream;
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    locationService = LocationService();
    locationStream = locationService.locationStream;
    locationService.requestLocationPermission();
  }

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  Widget buildLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void zoomIn() {
    mapController.move(mapController.center, mapController.zoom + 1);
  }

  void zoomOut() {
    mapController.move(mapController.center, mapController.zoom - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lokasi Kamu"),
      ),
      body: Center(
        child: StreamBuilder<UserLocation>(
          stream: locationStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userLocation = snapshot.data!;
              return Stack(
                children: [
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      center: LatLng(
                        userLocation.latitude ?? 0.0,
                        userLocation.longitude ?? 0.0,
                      ),
                      zoom: 13.0,
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayerOptions(
                        markers: [
                          Marker(
                            width: 100.0,
                            height: 100.0,
                            point: LatLng(
                              userLocation.latitude ?? 0.0,
                              userLocation.longitude ?? 0.0,
                            ),
                            builder: (ctx) => Container(
                              child: Icon(
                                Icons.circle,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: zoomIn,
                          child: Icon(Icons.add),
                        ),
                        SizedBox(height: 10),
                        FloatingActionButton(
                          onPressed: zoomOut,
                          child: Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return buildLoadingView();
            }
          },
        ),
      ),
    );
  }
}
