import 'package:flutter_test/flutter_test.dart';
import 'package:system_date_time_format/src/errors/sdtf_scope_not_found_error.dart';

void main() {
  group('SDTFScopeNotFoundError', () {
    test('toString returns correct message', () {
      final error = SDTFScopeNotFoundError(Type);
      const expected = '''
Error: Could not find the SDTFScope above this Type Widget

This happens because you used a `BuildContext` that does not include the SDTFScope.

if you want to use: 

SystemDateTimeFormat.of(context)

you have to wrap your root Widget e.g. App() in SDTFScope
''';
      expect(error.toString(), expected);
    });
  });
}
