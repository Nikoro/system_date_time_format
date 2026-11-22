import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:system_date_time_format/src/system_date_time_format_platform_interface.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

import '../_tools/tools.dart';

void main() {
  test(
    'reads the host patterns synchronously',
    () {
      expect(SystemDateTimeFormat.datePattern, isNotEmpty);
      expect(SystemDateTimeFormat.longDatePattern, isNotEmpty);
      expect(SystemDateTimeFormat.timePattern, isNotEmpty);
      if (Platform.isMacOS) {
        expect(SystemDateTimeFormat.mediumDatePattern, isNotEmpty);
        expect(SystemDateTimeFormat.fullDatePattern, isNotEmpty);
      } else {
        expect(SystemDateTimeFormat.mediumDatePattern, isNull);
        expect(SystemDateTimeFormat.fullDatePattern, isNull);
      }
    },
    skip:
        kIsWeb || !(Platform.isMacOS || Platform.isLinux || Platform.isWindows),
  );

  group('SystemDateTimeFormat', () {
    late MockSystemDateTimeFormatPlatform platform;
    late SystemDateTimeFormatPlatformInterface originalPlatform;

    setUp(() {
      originalPlatform = SystemDateTimeFormatPlatformInterface.instance;
      platform = MockSystemDateTimeFormatPlatform();
      when(() => platform.getDatePattern()).thenReturn(Stubs.datePattern);
      when(
        () => platform.getMediumDatePattern(),
      ).thenReturn(Stubs.mediumDatePattern);
      when(
        () => platform.getLongDatePattern(),
      ).thenReturn(Stubs.longDatePattern);
      when(
        () => platform.getFullDatePattern(),
      ).thenReturn(Stubs.fullDatePattern);
      when(() => platform.getTimePattern()).thenReturn(Stubs.timePattern);
      SystemDateTimeFormatPlatformInterface.instance = platform;
    });

    tearDown(() {
      SystemDateTimeFormatPlatformInterface.instance = originalPlatform;
    });

    test('exposes the individual patterns', () {
      expect(SystemDateTimeFormat.datePattern, Stubs.datePattern);
      expect(SystemDateTimeFormat.mediumDatePattern, Stubs.mediumDatePattern);
      expect(SystemDateTimeFormat.longDatePattern, Stubs.longDatePattern);
      expect(SystemDateTimeFormat.fullDatePattern, Stubs.fullDatePattern);
      expect(SystemDateTimeFormat.timePattern, Stubs.timePattern);
    });

    test('normalizes empty patterns to null', () {
      when(() => platform.getDatePattern()).thenReturn('');
      expect(SystemDateTimeFormat.datePattern, isNull);
    });

    test('reads only the requested pattern and reads it fresh each time', () {
      expect(SystemDateTimeFormat.datePattern, Stubs.datePattern);

      when(() => platform.getDatePattern()).thenReturn('yyyy-MM-dd');
      expect(SystemDateTimeFormat.datePattern, 'yyyy-MM-dd');

      verify(() => platform.getDatePattern()).called(2);
      verifyNoMoreInteractions(platform);
    });
  });
}
