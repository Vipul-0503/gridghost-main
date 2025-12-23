import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RiskIndicator extends StatelessWidget {
  final double score; // Expected 0.0 to 1.0

  const RiskIndicator({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0, maximum: 100,
          ranges: <GaugeRange>[
            GaugeRange(startValue: 0, endValue: 40, color: Colors.green),
            GaugeRange(startValue: 40, endValue: 70, color: Colors.orange),
            GaugeRange(startValue: 70, endValue: 100, color: Colors.red),
          ],
          pointers: <GaugePointer>[NeedlePointer(value: score * 100)],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text('${(score * 100).toInt()}%',
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              angle: 90, positionFactor: 0.5,
            )
          ],
        )
      ],
    );
  }
}