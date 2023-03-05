import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:system_date_time_format/system_date_time_format.dart';
import 'package:system_date_time_format_example_with_tests/app.dart';
import 'package:system_date_time_format_example_with_tests/dependency_injection/injection.dart';
import 'package:system_date_time_format_example_with_tests/widgets/widgets.dart';

import '_tools/tools.dart';

void main() {
  setUp(() {
    final mockSDTFormat = MockSystemDateTimeFormat();
    when(() => mockSDTFormat.dateFormat).thenReturn(Stubs.dateFormat);
    when(() => mockSDTFormat.mediumDateFormat)
        .thenReturn(Stubs.mediumDateFormat);
    when(() => mockSDTFormat.longDateFormat).thenReturn(Stubs.longDateFormat);
    when(() => mockSDTFormat.timeFormat).thenReturn(Stubs.timeFormat);

    getIt.registerSingleton<SystemDateTimeFormat>(mockSDTFormat);
  });

  testWidgets('App displays 4 RowItems with Date & Time formats',
      (tester) async {
    await tester.pumpWidget(const App());

    final rowItems = tester.widgetListByType<RowItem>();

    expect(rowItems.length, 4);
    expect(rowItems[0].value, Stubs.dateFormat);
    expect(rowItems[1].value, Stubs.mediumDateFormat);
    expect(rowItems[2].value, Stubs.longDateFormat);
    expect(rowItems[3].value, Stubs.timeFormat);
  });
}
