import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:system_date_time_format_example_with_tests/device_formats.dart';
import 'package:system_date_time_format_example_with_tests/fallbacks.dart';
import 'package:system_date_time_format_example_with_tests/main.dart';
import 'package:system_date_time_format_example_with_tests/widgets/widgets.dart';

class MockDeviceFormats extends Mock implements DeviceFormats {}

void main() {
  testWidgets('displays each supplied pattern under its own label', (
    tester,
  ) async {
    final formats = MockDeviceFormats();
    when(() => formats.shortDate).thenReturn('dd.MM.yy');
    when(() => formats.mediumDate).thenReturn('dd MMM y');
    when(() => formats.longDate).thenReturn('d MMMM y');
    when(() => formats.fullDate).thenReturn('EEEE, d MMMM y');
    when(() => formats.time).thenReturn('HH:mm');

    await tester.pumpWidget(App(formats: formats));

    final rows = tester.widgetList<RowItem>(find.byType(RowItem));
    expect(
      {for (final row in rows) row.title: row.value},
      {
        'Short date format pattern:': 'dd.MM.yy',
        'Medium date format pattern:': 'dd MMM y',
        'Long date format pattern:': 'd MMMM y',
        'Full date format pattern:': 'EEEE, d MMMM y',
        'Time format pattern:': 'HH:mm',
      },
    );
  });

  testWidgets('uses fallbacks for unavailable date styles', (tester) async {
    final formats = MockDeviceFormats();
    when(() => formats.mediumDate).thenReturn(null);
    when(() => formats.fullDate).thenReturn(null);
    when(() => formats.time).thenReturn('HH:mm');

    await tester.pumpWidget(App(formats: formats));

    expect(find.text(Fallbacks.mediumDatePattern), findsOneWidget);
    expect(find.text(Fallbacks.fullDatePattern), findsOneWidget);
    expect(find.text('HH:mm'), findsOneWidget);
  });
}
