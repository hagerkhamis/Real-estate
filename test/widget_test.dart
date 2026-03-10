import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/app.dart';

void main() {
  testWidgets('Splash screen shows correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: RealEstateApp(),
      ),
    );

    // Verify that the splash screen text appears.
    expect(find.text('AQARI'), findsOneWidget);
  });
}
