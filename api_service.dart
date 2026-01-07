import 'dart:convert'; // Will no longer be yellow
import 'package:http/http.dart' as http; // Will no longer be yellow
import '../constants.dart'; // Will no longer be yellow
import '../../models/pole_model.dart';

class ApiService {
  static Future<double> getLatestRiskScore() async {
    try {
      // 1. Using AppConstants and http (removes yellow)
      final url = Uri.parse("${AppConstants.apiBaseUrl}/risk-score");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // 2. Using json.decode (removes yellow)
        final Map<String, dynamic> data = json.decode(response.body);
        return (data['score'] as num).toDouble();
      }
      return 0.5; // Default mock score if server is down
    } catch (e) {
      // Fallback for development so you can still see the UI
      return 0.82; 
    }
  }

  static Future<List<DangerPole>> fetchDangerPoles() async {
    try {
      final response = await http.get(Uri.parse("${AppConstants.apiBaseUrl}/poles"));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => DangerPole.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}