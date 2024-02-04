import 'package:flutter_test/flutter_test.dart';
import 'package:system_date_time_format/src/errors/not_initialized_error.dart';

void main() {
  group('NotInitializedError', () {
    test('toString returns correct message', () {
      const name = 'name';
      final error = NotInitializedError(name);
      const expected =
          '$name was called before initialization\n\n\nDid you forget to call:\n\nSystemDateTimeFormat().initialize()\n\n';
      expect(error.toString(), expected);
    });
  });
}
