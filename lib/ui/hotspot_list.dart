import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HotspotList extends StatelessWidget {
  const HotspotList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('theft_hotspots')
          .where('city', isEqualTo: 'Jaipur')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading hotspots'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final d = docs[index];

            return ListTile(
              title: Text('Risk score: ${d['risk_score']}'),
              subtitle: Text('Lat: ${d['latitude']}, Lng: ${d['longitude']}'),
            );
          },
        );
      },
    );
  }
}
