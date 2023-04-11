import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

import '../../_tools/tools.dart';

void main() {
  late MockSystemDateTimeFormat mockSDTFormat;

  setUp(() {
    mockSDTFormat = MockSystemDateTimeFormat();
    when(() => mockSDTFormat.getAllPatterns())
        .thenAnswer((_) async => Stubs.allPatterns);
  });

  testWidgets('getAllPatterns() is called on resume', (tester) async {
    await tester.pumpWidget(
      SDTFScope(format: mockSDTFormat, child: const Placeholder()),
    );
    verify(() => mockSDTFormat.getAllPatterns()).called(1);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);

    verify(() => mockSDTFormat.getAllPatterns()).called(1);
  });
}
