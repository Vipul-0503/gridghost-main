import 'package:flutter/material.dart';

class ARGuidanceScreen extends StatelessWidget {
  const ARGuidanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AR Field Guidance"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.view_in_ar, size: 80),
            SizedBox(height: 16),
            Text(
              "AR module will be enabled soon",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
