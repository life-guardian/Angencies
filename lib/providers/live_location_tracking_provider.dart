import 'dart:async';

import 'package:agencies_app/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:geolocator/geolocator.dart';

// Location provider for centralized management
final locationProvider = Provider((ref) {
  final streamController = StreamController<Position>.broadcast(); // Broadcast for multiple listeners
  StreamSubscription<Position>? positionStreamSubscription;

  Future<void> startTrackingLocation() async {
    // 1. Check and Request Permissions (if necessary)
    LocationPermission permission = await geo.Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // 2. Start Location Stream with Desired Accuracy
      geo.LocationSettings locationSettings = const geo.LocationSettings(
        accuracy: geo.LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
      );

      positionStreamSubscription = geo.Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen((Position position) {
        // 3. Add position to stream
        ref.read(deviceLocationProvider.notifier).state = [
          position.latitude,
          position.longitude
        ];
        streamController.add(position);
      });
    } else {
      debugPrint("Location permission denied - cannot track location.");
    }
  }

  Future<void> stopTrackingLocation() async {
    await positionStreamSubscription?.cancel();
  }

  @override
  void dispose() {
    stopTrackingLocation();
    streamController.close();
    // super.dispose();
  }

  return StreamProvider<Position>(
    (ref) => streamController.stream,
  );
});
