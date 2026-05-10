import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner/main.dart';

void main() {
  testWidgets('App basic load test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StudyPlannerApp());

    // Verify that the home screen title exists.
    expect(find.text("تطبيق مهامي الدراسية"), findsOneWidget);
  });
}
