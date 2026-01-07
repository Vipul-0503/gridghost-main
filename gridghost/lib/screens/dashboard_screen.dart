import 'package:flutter/material.dart';
import '../widgets/risk_indicator.dart';
import '../core/services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<double> _riskScoreFuture;

  @override
  void initState() {
    super.initState();
    _riskScoreFuture = ApiService.getLatestRiskScore();
  }

  // Manual refresh logic for the field
  Future<void> _refreshData() async {
    setState(() {
      _riskScoreFuture = ApiService.getLatestRiskScore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GridGhost Dashboard")),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<double>(
          future: _riskScoreFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            
            final score = snapshot.data ?? 0.0;
            return ListView( // Use ListView for RefreshIndicator to work
              padding: const EdgeInsets.symmetric(vertical: 40),
              children: [
                const Center(child: Text("ZONE THEFT RISK", style: TextStyle(letterSpacing: 2))),
                const SizedBox(height: 20),
                SizedBox(height: 300, child: RiskIndicator(score: score)),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text("Status: Scanning Zone..."),
                      subtitle: Text("Data provided by live AIML satellite stream."),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}