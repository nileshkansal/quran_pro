import 'package:flutter_test/flutter_test.dart';

import 'package:quran_pro/main.dart';

void main() {
  testWidgets('Splash shows tagline then moves to language selection', (tester) async {
    await tester.pumpWidget(const QuranProApp());
    expect(find.text('RECITE | UNDERSTAND | TRANSFORM'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Select your preferred language to begin'), findsOneWidget);
    expect(find.text('Bismillah'), findsOneWidget);
  });
}
