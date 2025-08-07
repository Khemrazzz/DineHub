import 'package:flutter_test/flutter_test.dart';
import 'package:dinehub/main.dart';

void main() {
  testWidgets('App shows DineHub title', (WidgetTester tester) async {
    await tester.pumpWidget(const DineHubApp());
    expect(find.text('DineHub'), findsWidgets);
  });
}
