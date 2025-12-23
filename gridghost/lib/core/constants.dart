import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppConstants {
  // Replace with your actual backend URL from the AIML stream
  static const String apiBaseUrl = "https://your-aiml-backend.com/api";
  
  // Default map position (Matches Jaipur coordinates from your screenshot)
  static const LatLng defaultLocation = LatLng(26.9124, 75.7873);
  
  // UI Styles
  static const double defaultPadding = 20.0;
}