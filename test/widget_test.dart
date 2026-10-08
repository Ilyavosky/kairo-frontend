import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/main.dart';

void main() {
  testWidgets('shows the app name on screen', (tester) async {
    await tester.pumpWidget(const KairoApp());

    expect(find.text('Kairo'), findsOneWidget);
  });
}
