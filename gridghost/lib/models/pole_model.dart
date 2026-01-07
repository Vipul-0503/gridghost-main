class DangerPole {
  final String id;
  final double lat;
  final double lng;
  final double riskScore;

  DangerPole({
    required this.id,
    required this.lat,
    required this.lng,
    required this.riskScore,
  });

  // This factory constructor is what the ApiService is looking for
  factory DangerPole.fromJson(Map<String, dynamic> json) {
    return DangerPole(
      id: json['id']?.toString() ?? 'unknown',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
      riskScore: (json['riskScore'] as num?)?.toDouble() ?? 0.0,
    );
  }
}