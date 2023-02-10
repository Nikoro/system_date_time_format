import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:system_date_time_format/src/system_date_time_format_platform_interface.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

import '../_tools/tools.dart';

void main() {
  setUpAll(() {
    final platform = MockSystemDateTimeFormatPlatform();
    String anyFallback() => any(named: 'fallback');

    when(() => platform.getDateFormat(fallback: anyFallback())).thenAnswer((_) async => Stubs.dateFormat);
    when(() => platform.getMediumDateFormat(fallback: anyFallback())).thenAnswer((_) async => Stubs.mediumDateFormat);
    when(() => platform.getLongDateFormat(fallback: anyFallback())).thenAnswer((_) async => Stubs.longDateFormat);
    when(() => platform.getTimeFormat(fallback: anyFallback())).thenAnswer((_) async => Stubs.timeFormat);

    SystemDateTimeFormatPlatformInterface.instance = platform;
  });

  group('SystemDateTimeFormat', () {
    test('is Singleton', () async {
      final s1 = SystemDateTimeFormat();
      final s2 = SystemDateTimeFormat();
      expect(identical(s1, s2), true);
      expect(s1 == s2, true);
    });

    test('dateFormat returns correct format: [${Stubs.dateFormat}]', () async {
      await SystemDateTimeFormat().initialize();
      expect(SystemDateTimeFormat().dateFormat, Stubs.dateFormat);
    });

    test('mediumDateFormat returns correct format: [${Stubs.mediumDateFormat}]', () async {
      await SystemDateTimeFormat().initialize();
      expect(SystemDateTimeFormat().mediumDateFormat, Stubs.mediumDateFormat);
    });

    test('longDateFormat returns correct format: [${Stubs.longDateFormat}]', () async {
      await SystemDateTimeFormat().initialize();
      expect(SystemDateTimeFormat().longDateFormat, Stubs.longDateFormat);
    });

    test('timeFormat returns correct format: [${Stubs.timeFormat}]', () async {
      await SystemDateTimeFormat().initialize();
      expect(SystemDateTimeFormat().timeFormat, Stubs.timeFormat);
    });
  });
}
