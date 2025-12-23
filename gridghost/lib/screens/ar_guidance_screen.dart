import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import '../core/services/location_service.dart';
import '../widgets/ar_overlay_ui.dart';

class ARGuidanceScreen extends StatefulWidget {
  const ARGuidanceScreen({super.key});

  @override
  State<ARGuidanceScreen> createState() => _ARGuidanceScreenState();
}

class _ARGuidanceScreenState extends State<ARGuidanceScreen> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  
  // Navigation variables for the lineman
  double _distanceToPole = 0.0;
  bool _isNearPole = false;

  @override
  void initState() {
    super.initState();
    _startDistanceTracking();
  }

  // Continuously update distance to the "Danger Pole"
  void _startDistanceTracking() {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (!mounted) return;
      
      try {
        final userPos = await LocationService.getCurrentLocation();
        // Mock pole coordinates in Jaipur
        const double poleLat = 26.9124;
        const double poleLng = 75.7873;

        double distance = LocationService.getDistanceToPole(
          userPos.latitude,
          userPos.longitude,
          poleLat,
          poleLng,
        );

        setState(() {
          _distanceToPole = distance;
          _isNearPole = distance < 10.0; // Flagged as near if within 10 meters
        });
      } catch (e) {
        debugPrint("Location error: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AR Field Guidance"),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "${_distanceToPole.toStringAsFixed(1)}m",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          // 1. THE AR CAMERA FEED
          ARView(
            onARViewCreated: onARViewCreated,
          ),
          
          // 2. THE UI OVERLAY
          ArOverlayUi(
            onAddPin: _addDangerPin,
          ),
          
          // 3. PROXIMITY ALERT
          if (_isNearPole)
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "DANGER: POLE DETECTED NEARBY",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void onARViewCreated(
      ARSessionManager session, ARObjectManager object, dynamic anchor, dynamic location) {
    arSessionManager = session;
    arObjectManager = object;

    arSessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      showWorldOrigin: false,
    );
    arObjectManager!.onInitialize();
  }

  // Places the 3D "Danger Pin" in the AR world
  Future<void> _addDangerPin() async {
    var newNode = ARNode(
      type: NodeType.localGLTF2,
      uri: "assets/models/danger_pin.gltf", 
      position: vector.Vector3(0, 0, -2.0), // Places 2 meters in front of user
      scale: vector.Vector3(0.5, 0.5, 0.5),
    );
    
    bool? didAdd = await arObjectManager?.addNode(newNode);
    
    // FIX: Ensures context is only used if the widget is still in the tree
    if (!mounted) return; 

    if (didAdd == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Danger Pin Placed at Infrastructure")),
      );
    }
  }

  @override
  void dispose() {
    arSessionManager?.dispose();
    super.dispose();
  }
}