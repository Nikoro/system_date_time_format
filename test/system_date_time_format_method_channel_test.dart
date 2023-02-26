import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_date_time_format/src/fallbacks.dart';
import 'package:system_date_time_format/src/system_date_time_format_method_channel.dart';

import '_tools/tools.dart';

void main() {
  final platform = MethodChannelSystemDateTimeFormat();
  const channel = MethodChannel('system_date_time_format');

  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() => channel.setMockMethodCallHandler(null));

  group('MethodChannelSystemDateTimeFormat', () {
    [
      [
        platform.getDateFormat,
        Stubs.dateFormat,
        Fallbacks.dateFormat,
      ],
      [
        platform.getMediumDateFormat,
        Stubs.mediumDateFormat,
        Fallbacks.mediumDateFormat,
      ],
      [
        platform.getLongDateFormat,
        Stubs.longDateFormat,
        Fallbacks.longDateFormat,
      ],
      [
        platform.getTimeFormat,
        Stubs.timeFormat,
        Fallbacks.timeFormat,
      ],
    ].forEach((input) {
      final function =
          input.first as Future<String> Function({required String fallback});
      final expectedValue = input.second as String;
      final expectedFallback = input.third as String;

      test('${function.name} returns correct format: [$expectedValue]',
          () async {
        channel.setMockMethodCallHandler((_) async => expectedValue);

        final result = await function(fallback: expectedFallback);
        expect(result, expectedValue);
      });

      test(
          '${function.name} returns fallback format: [$expectedFallback] on error',
          () async {
        channel.setMockMethodCallHandler((_) async => null);

        final result = await function(fallback: expectedFallback);
        expect(result, expectedFallback);
      });
    });
  });
}
