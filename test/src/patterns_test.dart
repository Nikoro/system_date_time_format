import 'package:flutter_test/flutter_test.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

void main() {
  const patterns1 = Patterns(
    datePattern: 'datePattern',
    mediumDatePattern: 'mediumDatePattern',
    longDatePattern: 'longDatePattern',
    timePattern: 'timePattern',
  );
  const patterns2 = Patterns(
    datePattern: 'datePattern',
    mediumDatePattern: 'mediumDatePattern',
    longDatePattern: 'longDatePattern',
    timePattern: 'timePattern',
  );
  const patterns3 = Patterns();

  group('Patterns', () {
    test('equality', () {
      expect(patterns1 == patterns2, true);
      expect(patterns2 != patterns3, true);
    });

    test('hashCode', () {
      expect(patterns1.hashCode == patterns2.hashCode, true);
      expect(patterns2.hashCode != patterns3.hashCode, true);
    });
  });
}
