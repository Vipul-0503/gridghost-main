import 'package:flutter_test/flutter_test.dart';
import 'package:gridghost/main.dart';

void main() {
  testWidgets('GridGhost smoke test', (WidgetTester tester) async {
    // UPDATED: Changed MyApp() to GridGhostApp()
    await tester.pumpWidget(const GridGhostApp());

    // Note: Since we removed the "Counter" logic from main.dart
    // and replaced it with your Dashboard/AR Hub, 
    // the original "0" and "1" tests below will fail.
    // For now, we just want the code to compile.
  });
}