import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native/pattern_kind.dart';
import 'native/read_pattern_stub.dart'
    if (dart.library.io) 'native/read_pattern.dart';

abstract class SystemDateTimeFormatPlatformInterface extends PlatformInterface {
  /// Constructs a SystemDateTimeFormatPlatform.
  SystemDateTimeFormatPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static SystemDateTimeFormatPlatformInterface _instance =
      _DefaultSystemDateTimeFormat();

  /// The default instance of [SystemDateTimeFormatPlatformInterface] to use.
  static SystemDateTimeFormatPlatformInterface get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SystemDateTimeFormatPlatformInterface] when
  /// they register themselves.
  static set instance(SystemDateTimeFormatPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Method signature for returning short version of date format pattern
  String? getDatePattern();

  /// Method signature for returning medium version of date format pattern
  String? getMediumDatePattern();

  /// Method signature for returning long version of date format pattern
  String? getLongDatePattern();

  /// Method signature for returning full version of date format pattern
  String? getFullDatePattern();

  /// Method signature for returning time format pattern
  String? getTimePattern();
}

class _DefaultSystemDateTimeFormat
    extends SystemDateTimeFormatPlatformInterface {
  @override
  String? getDatePattern() => readPattern(PatternKind.date);

  @override
  String? getMediumDatePattern() => readPattern(PatternKind.mediumDate);

  @override
  String? getLongDatePattern() => readPattern(PatternKind.longDate);

  @override
  String? getFullDatePattern() => readPattern(PatternKind.fullDate);

  @override
  String? getTimePattern() => readPattern(PatternKind.time);
}
