import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/map_view_screen.dart';
import 'screens/ar_guidance_screen.dart';

void main() => runApp(const GridGhostApp());

class GridGhostApp extends StatelessWidget {
  const GridGhostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const MainNavigationHub(),
    );
  }
}

class MainNavigationHub extends StatefulWidget {
  const MainNavigationHub({super.key});
  @override
  State<MainNavigationHub> createState() => _MainNavigationHubState();
}

class _MainNavigationHubState extends State<MainNavigationHub> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const DashboardScreen(), // Requirement: App Architecture
    const MapViewScreen(),    // Requirement: Visual Storytelling
    const ARGuidanceScreen(), // Requirement: AR Field Guidance
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Risk Score"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Heatmap"),
          BottomNavigationBarItem(icon: Icon(Icons.view_in_ar), label: "AR Guide"),
        ],
      ),
    );
  }
}