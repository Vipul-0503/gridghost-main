
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/pole_model.dart'; // This is the crucial one!
class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  // Mock data for "Theft Heatmap" from AIML stream
  final List<DangerPole> _mockPoles = [
    DangerPole(id: "P1", lat: 26.9124, lng: 75.7873, riskScore: 0.9),
    DangerPole(id: "P2", lat: 26.9150, lng: 75.7890, riskScore: 0.7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(26.9124, 75.7873),
          zoom: 14,
        ),
        circles: _mockPoles.map((pole) => Circle(
          circleId: CircleId(pole.id),
          center: LatLng(pole.lat, pole.lng),
          radius: 150,
          fillColor: Colors.red.withValues(alpha: 0.3),
          strokeColor: Colors.red,
          strokeWidth: 1,
        )).toSet(),
        markers: _mockPoles.map((pole) => Marker(
          markerId: MarkerId(pole.id),
          position: LatLng(pole.lat, pole.lng),
          infoWindow: InfoWindow(title: "Risk Score: ${pole.riskScore}"),
        )).toSet(),
      ),
    );
  }
}