import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:system_date_time_format/src/system_date_time_format_platform_interface.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

import '../_tools/tools.dart';

void main() {
  setUpAll(() {
    final platform = MockSystemDateTimeFormatPlatform();

    when(() => platform.getDatePattern())
        .thenAnswer((_) async => Stubs.datePattern);
    when(() => platform.getMediumDatePattern())
        .thenAnswer((_) async => Stubs.mediumDatePattern);
    when(() => platform.getLongDatePattern())
        .thenAnswer((_) async => Stubs.longDatePattern);
    when(() => platform.getTimePattern())
        .thenAnswer((_) async => Stubs.timePattern);

    SystemDateTimeFormatPlatformInterface.instance = platform;
  });

  group('SystemDateTimeFormat', () {
    test('is Singleton', () async {
      final s1 = SystemDateTimeFormat();
      final s2 = SystemDateTimeFormat();
      expect(identical(s1, s2), true);
      expect(s1 == s2, true);
    });

    [
      [SystemDateTimeFormat().getDatePattern, Stubs.datePattern],
      [SystemDateTimeFormat().getMediumDatePattern, Stubs.mediumDatePattern],
      [SystemDateTimeFormat().getLongDatePattern, Stubs.longDatePattern],
      [SystemDateTimeFormat().getTimePattern, Stubs.timePattern],
    ].forEach((input) {
      final function = input.first as Future<String?> Function();
      final expectedValue = input.second as String;

      test('${function.name}() returns correct pattern: [$expectedValue]',
          () async {
        final result = await function();
        expect(result, expectedValue);
      });
    });

    test('dateFormat returns correct pattern: [${Stubs.datePattern}]', () async {
      await SystemDateTimeFormat().initialize();
      expect(SystemDateTimeFormat().dateFormat, Stubs.datePattern);
    });

    test('mediumDateFormat returns correct pattern: [${Stubs.mediumDatePattern}]',
        () async {
      await SystemDateTimeFormat().initialize();
      expect(SystemDateTimeFormat().mediumDateFormat, Stubs.mediumDatePattern);
    });

    test('longDateFormat returns correct pattern: [${Stubs.longDatePattern}]',
        () async {
      await SystemDateTimeFormat().initialize();
      expect(SystemDateTimeFormat().longDateFormat, Stubs.longDatePattern);
    });

    test('timeFormat returns correct pattern: [${Stubs.timePattern}]', () async {
      await SystemDateTimeFormat().initialize();
      expect(SystemDateTimeFormat().timeFormat, Stubs.timePattern);
    });
  });
}
