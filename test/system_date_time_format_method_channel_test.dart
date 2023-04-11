import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_date_time_format/src/system_date_time_format_method_channel.dart';

import '_tools/tools.dart';

void main() {
  final platform = MethodChannelSystemDateTimeFormat();
  const channel = MethodChannel('system_date_time_format');

  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() => channel.setMockMethodCallHandler(null));

  group('MethodChannelSystemDateTimeFormat', () {
    [
      [platform.getDatePattern, Stubs.datePattern],
      [platform.getMediumDatePattern, Stubs.mediumDatePattern],
      [platform.getLongDatePattern, Stubs.longDatePattern],
      [platform.getTimePattern, Stubs.timePattern],
    ].forEach((input) {
      final function = input.first as Future<String?> Function();
      final expectedValue = input.second as String;

      test('${function.name}() returns correct format: [$expectedValue]',
          () async {
        channel.setMockMethodCallHandler((_) async => expectedValue);

        final result = await function();
        expect(result, expectedValue);
      });
    });
  });
}
