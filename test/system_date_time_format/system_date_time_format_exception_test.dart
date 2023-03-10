import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:system_date_time_format/src/fallbacks.dart';
import 'package:system_date_time_format/src/system_date_time_format_platform_interface.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

import '../_tools/tools.dart';

void main() {
  setUp(() {
    final platform = MockSystemDateTimeFormatPlatform();

    String anyFallback() => any(named: 'fallback');
    asyncPlatformException(_) async => throw PlatformException(code: '');

    when(() => platform.getDateFormat(fallback: anyFallback()))
        .thenAnswer(asyncPlatformException);
    when(() => platform.getMediumDateFormat(fallback: anyFallback()))
        .thenAnswer(asyncPlatformException);
    when(() => platform.getLongDateFormat(fallback: anyFallback()))
        .thenAnswer(asyncPlatformException);
    when(() => platform.getTimeFormat(fallback: anyFallback()))
        .thenAnswer(asyncPlatformException);

    SystemDateTimeFormatPlatformInterface.instance = platform;
  });

  group('SystemDateTimeFormat', () {
    test(
        'dateFormat returns fallback format: [${Fallbacks.dateFormat}] on PlatformException',
        () async {
      await SystemDateTimeFormat().initialize();
      expect(SystemDateTimeFormat().dateFormat, Fallbacks.dateFormat);
    });

    test(
        'mediumDateFormat returns fallback format: [${Fallbacks.mediumDateFormat}] on PlatformException',
        () async {
      await SystemDateTimeFormat().initialize();
      expect(
          SystemDateTimeFormat().mediumDateFormat, Fallbacks.mediumDateFormat);
    });

    test(
        'longDateFormat returns fallback format: [${Fallbacks.longDateFormat}] on PlatformException',
        () async {
      await SystemDateTimeFormat().initialize();
      expect(SystemDateTimeFormat().longDateFormat, Fallbacks.longDateFormat);
    });

    test(
        'timeFormat returns fallback format: [${Fallbacks.timeFormat}] on PlatformException',
        () async {
      await SystemDateTimeFormat().initialize();
      expect(SystemDateTimeFormat().timeFormat, Fallbacks.timeFormat);
    });
  });
}
