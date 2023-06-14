import 'dart:async';

import 'package:geolocator/geolocator.dart';

class UserLocation {
  final double? latitude;
  final double? longitude;

  UserLocation(this.latitude, this.longitude);
}

class LocationService {
  GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  StreamController<UserLocation> _locationStreamController =
      StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  LocationService() {
    _startListening();
  }

  void _startListening() async {
    if (!(await geolocator.isLocationServiceEnabled())) {
      return;
    }

    geolocator.checkPermission().then((LocationPermission permission) {
      if (permission == LocationPermission.deniedForever) {
        return;
      }

      if (permission == LocationPermission.denied) {
        geolocator.requestPermission().then((LocationPermission permission) {
          if (permission == LocationPermission.denied ||
              permission == LocationPermission.deniedForever) {
            return;
          }

          _getLocation();
        });
      } else {
        _getLocation();
      }
    });
  }

  void _getLocation() async {
    try {
      geolocator.getPositionStream().listen((Position position) {
        _locationStreamController.add(UserLocation(
          position.latitude,
          position.longitude,
        ));
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void dispose() {
    _locationStreamController.close();
  }

  void requestLocationPermission() {}
}
