import 'package:flutter/material.dart';

class ArOverlayUi extends StatelessWidget {
  final VoidCallback onAddPin;

  const ArOverlayUi({super.key, required this.onAddPin});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Point camera at a power pole to see Danger Pins",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: onAddPin,
            icon: const Icon(Icons.location_on),
            label: const Text("Manually Mark Pole"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
        ],
      ),
    );
  }
}