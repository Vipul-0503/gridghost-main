import 'package:geolocator/geolocator.dart';
import 'dart:async';

class LocationService {
  /// 1. Check Permissions and Get Current Position
  /// This fulfills the "Navigation" requirement for the lineman.
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled. Please enable GPS.');
    }

    // Check for permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Fetch position with high accuracy for AR alignment
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// 2. Live Location Stream
  /// Keeps the "Theft Heatmap" updated as the lineman moves.
  static Stream<Position> getLiveLocationStream() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5, // Updates every 5 meters moved
    );
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  /// 3. Calculate Distance to Flagged Pole
  /// Helps the lineman "find the exact pole flagged by the satellite".
  static double getDistanceToPole(
    double userLat, 
    double userLng, 
    double poleLat, 
    double poleLng
  ) {
    return Geolocator.distanceBetween(userLat, userLng, poleLat, poleLng);
  }

  /// 4. Bearing Calculation
  /// Essential for AR guidance to know which direction the lineman should look.
  static double getBearingToPole(
    double userLat, 
    double userLng, 
    double poleLat, 
    double poleLng
  ) {
    return Geolocator.bearingBetween(userLat, userLng, poleLat, poleLng);
  }
}