import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'system_date_time_format_method_channel.dart';

abstract class SystemDateTimeFormatPlatformInterface extends PlatformInterface {
  /// Constructs a SystemDateTimeFormatPlatform.
  SystemDateTimeFormatPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static SystemDateTimeFormatPlatformInterface _instance =
      MethodChannelSystemDateTimeFormat();

  /// The default instance of [SystemDateTimeFormatPlatformInterface] to use.
  ///
  /// Defaults to [MethodChannelSystemDateTimeFormat].
  static SystemDateTimeFormatPlatformInterface get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SystemDateTimeFormatPlatformInterface] when
  /// they register themselves.
  static set instance(SystemDateTimeFormatPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Method signature for returning short version of date format pattern
  Future<String?> getDatePattern();

  /// Method signature for returning medium version of date format pattern
  Future<String?> getMediumDatePattern();

  /// Method signature for returning long version of date format pattern
  Future<String?> getLongDatePattern();

  /// Method signature for returning time format pattern
  Future<String?> getTimePattern();
}
