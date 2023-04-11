import 'package:system_date_time_format/system_date_time_format.dart';

abstract class Stubs {
  Stubs._();

  static const datePattern = 'dd.MM.y';
  static const mediumDatePattern = 'd MMM y';
  static const longDatePattern = 'd MMMM y';
  static const timePattern = 'HH:mm';
  static const allPatterns = Patterns(
    datePattern: datePattern,
    mediumDatePattern: mediumDatePattern,
    longDatePattern: longDatePattern,
    timePattern: timePattern,
  );
}
