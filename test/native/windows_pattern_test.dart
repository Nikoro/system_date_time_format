import 'package:flutter_test/flutter_test.dart';
import 'package:system_date_time_format/src/native/windows_pattern.dart';

void main() {
  test('converts weekdays, era and day periods, preserving numeric days', () {
    expect(convertWindowsPattern('dddd, MMMM d, yyyy'), 'EEEE, MMMM d, yyyy');
    expect(convertWindowsPattern('ddd dd/MM/yy gg'), 'EEE dd/MM/yy G');
    expect(convertWindowsPattern('h:mm tt'), 'h:mm a');
    expect(convertWindowsPattern('h t'), 'h a');
  });

  test('leaves quoted fields and escaped apostrophes intact', () {
    expect(
      convertWindowsPattern("ddd 'dddd' 'it''s tt' h:mm tt"),
      "EEE 'dddd' 'it''s tt' h:mm a",
    );
    expect(convertWindowsPattern("''ddd''"), "''EEE''");
  });
}
