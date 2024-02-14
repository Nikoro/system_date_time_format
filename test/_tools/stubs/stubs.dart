import 'package:system_date_time_format/src/patterns.dart';

abstract class Stubs {
  Stubs._();

  static const datePattern = 'dd.MM.y';
  static const mediumDatePattern = 'd MMM y';
  static const longDatePattern = 'd MMMM y';
  static const fullDatePattern = 'EEEE d MMMM y';
  static const timePattern = 'HH:mm';
  static const allPatterns = Patterns(
    datePattern: datePattern,
    mediumDatePattern: mediumDatePattern,
    longDatePattern: longDatePattern,
    fullDatePattern: fullDatePattern,
    timePattern: timePattern,
  );

  static const differentDatePattern = 'differentDatePattern';
  static const differentMediumDatePattern = 'differentMediumDatePattern';
  static const differentLongDatePattern = 'differentLongDatePattern';
  static const differentFullDatePattern = 'differentFullDatePattern';
  static const differentTimePattern = 'differentTimePattern';
  static const allDifferentPatterns = Patterns(
    datePattern: differentDatePattern,
    mediumDatePattern: differentMediumDatePattern,
    longDatePattern: differentLongDatePattern,
    fullDatePattern: differentFullDatePattern,
    timePattern: differentTimePattern,
  );
}
