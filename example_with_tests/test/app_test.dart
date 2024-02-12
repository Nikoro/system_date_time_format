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
    when(() => mockSDTFormat.getAllPatterns())
        .thenAnswer((_) async => Stubs.allPatterns);
  });

  testWidgets(
      'App displays 5 RowItems with correct Date & Time format patterns',
      (tester) async {
    await tester.pumpWidget(
      SDTFScope(format: mockSDTFormat, child: const App()),
    );
    await tester.pump();

    final rowItems = tester.widgetListByType<RowItem>();

    expect(rowItems.length, 5);
    expect(rowItems[0].value, Stubs.datePattern);
    expect(rowItems[1].value, Stubs.mediumDatePattern);
    expect(rowItems[2].value, Stubs.longDatePattern);
    expect(rowItems[3].value, Stubs.fullDatePattern);
    expect(rowItems[4].value, Stubs.timePattern);
  });
}
