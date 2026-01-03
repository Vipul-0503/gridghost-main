import 'dart:convert';
import 'package:crypto/crypto.dart';

String generateEvidenceHash({
  required List<int> imageBytes,
  required String uid,
  required String timestamp,
}) {
  final combined = <int>[
    ...imageBytes,
    ...utf8.encode(uid),
    ...utf8.encode(timestamp),
  ];

  final digest = sha256.convert(combined);
  return digest.toString();
}
