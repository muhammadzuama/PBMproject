import 'package:flutter/material.dart';
import 'package:server_coba/location/location.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({Key? key}) : super(key: key);

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  late LocationService locationService;
  late Stream<UserLocation> locationStream;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<UserLocation>(
          stream: locationStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userLocation = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Latitude'),
                  Text(userLocation.latitude?.toString() ?? ''),
                  SizedBox(height: 10),
                  Text('Longitude'),
                  Text(userLocation.longitude?.toString() ?? ''),
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
