import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/pole_model.dart';

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  // Mock danger pole data (AIML output)
  List<DangerPole> get _mockPoles => [
        DangerPole(id: "P1", lat: 26.9124, lng: 75.7873, riskScore: 0.9),
        DangerPole(id: "P2", lat: 26.9150, lng: 75.7890, riskScore: 0.7),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Theft Risk Heatmap")),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(26.9124, 75.7873),
          initialZoom: 14,
        ),
        children: [
          // 🌍 OpenStreetMap tiles (FREE)
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.gridghost',
          ),

          // 🔴 Risk Heat Circles
          CircleLayer(
            circles: _mockPoles.map((pole) {
              return CircleMarker(
                point: LatLng(pole.lat, pole.lng),
                radius: 80,
                useRadiusInMeter: true,
                color: Colors.red.withValues(alpha: pole.riskScore),
                borderStrokeWidth: 1,
                borderColor: Colors.redAccent,
              );
            }).toList(),
          ),

          // 📍 Pole Markers
          MarkerLayer(
            markers: _mockPoles.map((pole) {
              return Marker(
                point: LatLng(pole.lat, pole.lng),
                width: 40,
                height: 40,
                child: Icon(
                  Icons.warning,
                  color: pole.riskScore > 0.8
                      ? Colors.red
                      : Colors.orange,
                  size: 30,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
