import 'package:latlong2/latlong.dart';

class AppConstants {
  static const String apiBaseUrl =
      "https://your-aiml-backend.com/api";

  // latlong2.LatLng is NOT const → must be final
  static const LatLng defaultLocation =
      LatLng(26.9124, 75.7873);

  static const double defaultPadding = 20.0;
}
