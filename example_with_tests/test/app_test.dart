import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:system_date_time_format/system_date_time_format.dart';
import 'package:system_date_time_format_example_with_tests/main.dart';
import 'package:system_date_time_format_example_with_tests/widgets/widgets.dart';

import '_tools/tools.dart';

void main() {
  late MockSystemDateTimeFormat mockSDTFormat;

  setUp(() {
    mockSDTFormat = MockSystemDateTimeFormat();
    const patterns = Patterns(
      datePattern: Stubs.datePattern,
      mediumDatePattern: Stubs.mediumDatePattern,
      longDatePattern: Stubs.longDatePattern,
      timePattern: Stubs.timePattern,
    );
    when(() => mockSDTFormat.getAllPatterns())
        .thenAnswer((_) async => patterns);
  });

  testWidgets(
      'App displays 4 RowItems with correct Date & Time format patterns',
      (tester) async {
    await tester.pumpWidget(
      SDTFScope(format: mockSDTFormat, child: const App()),
    );
    await tester.pump();

    final rowItems = tester.widgetListByType<RowItem>();

    expect(rowItems.length, 4);
    expect(rowItems[0].value, Stubs.datePattern);
    expect(rowItems[1].value, Stubs.mediumDatePattern);
    expect(rowItems[2].value, Stubs.longDatePattern);
    expect(rowItems[3].value, Stubs.timePattern);
  });
}
