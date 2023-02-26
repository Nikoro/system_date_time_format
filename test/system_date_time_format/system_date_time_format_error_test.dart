import 'package:flutter_test/flutter_test.dart';
import 'package:system_date_time_format/src/errors/not_ititialized_error.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

void main() {
  group('SystemDateTimeFormat', () {
    test('dateFormat throws NotInitializedError when not initialized', () {
      expect(
        () => SystemDateTimeFormat().dateFormat,
        throwsA(isA<NotInitializedError>()),
      );
    });

    test('mediumDateFormat throws NotInitializedError when not initialized',
        () {
      expect(
        () => SystemDateTimeFormat().mediumDateFormat,
        throwsA(isA<NotInitializedError>()),
      );
    });

    test('longDateFormat throws NotInitializedError when not initialized', () {
      expect(
        () => SystemDateTimeFormat().longDateFormat,
        throwsA(isA<NotInitializedError>()),
      );
    });

    test('timeFormat throws NotInitializedError when not initialized', () {
      expect(
        () => SystemDateTimeFormat().timeFormat,
        throwsA(isA<NotInitializedError>()),
      );
    });
  });
}
