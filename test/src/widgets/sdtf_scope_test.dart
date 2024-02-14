import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

import '../../_tools/tools.dart';

void main() {
  late MockSystemDateTimeFormat mockSDTFormat;

  setUp(() {
    mockSDTFormat = MockSystemDateTimeFormat();
    when(() => mockSDTFormat.getAllPatterns()).thenAnswerMany([
      (_) async => Stubs.allPatterns,
      (_) async => Stubs.allDifferentPatterns,
    ]);
  });

  group('SDTFScope', () {
    testWidgets('returns all patterns from system_date_time_format plugin',
        (tester) async {
      await tester.setupWidget(
        SDTFScope(format: mockSDTFormat, child: const TestWidget()),
      );
      await tester.pump();

      expect(find.text(Stubs.datePattern), findsOneWidget);
      expect(find.text(Stubs.mediumDatePattern), findsOneWidget);
      expect(find.text(Stubs.longDatePattern), findsOneWidget);
      expect(find.text(Stubs.fullDatePattern), findsOneWidget);
      expect(find.text(Stubs.timePattern), findsOneWidget);
    });

    testWidgets('getAllPatterns() is called on resume', (tester) async {
      await tester.pumpWidget(
        SDTFScope(format: mockSDTFormat, child: const Placeholder()),
      );
      verify(() => mockSDTFormat.getAllPatterns()).called(1);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);

      verify(() => mockSDTFormat.getAllPatterns()).called(1);
    });

    testWidgets(
        'returns all new different patterns from system_date_time_format plugin when patterns changed on resume',
        (tester) async {
      await tester.setupWidget(
        SDTFScope(format: mockSDTFormat, child: const TestWidget()),
      );
      await tester.pump();

      expect(find.text(Stubs.datePattern), findsOneWidget);
      expect(find.text(Stubs.mediumDatePattern), findsOneWidget);
      expect(find.text(Stubs.longDatePattern), findsOneWidget);
      expect(find.text(Stubs.fullDatePattern), findsOneWidget);
      expect(find.text(Stubs.timePattern), findsOneWidget);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      expect(find.text(Stubs.differentDatePattern), findsOneWidget);
      expect(find.text(Stubs.differentMediumDatePattern), findsOneWidget);
      expect(find.text(Stubs.differentLongDatePattern), findsOneWidget);
      expect(find.text(Stubs.differentFullDatePattern), findsOneWidget);
      expect(find.text(Stubs.differentTimePattern), findsOneWidget);
    });
  });
}
