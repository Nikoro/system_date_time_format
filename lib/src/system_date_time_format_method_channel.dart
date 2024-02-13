import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'system_date_time_format_platform_interface.dart';

/// An implementation of [SystemDateTimeFormatPlatformInterface] that uses method channels.
class MethodChannelSystemDateTimeFormat
    extends SystemDateTimeFormatPlatformInterface {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('system_date_time_format');

  /// Invokes "getDateFormat" method on system_date_time_format [methodChannel]
  /// returning dateFormat
  @override
  Future<String?> getDatePattern() {
    return methodChannel.invokeMethod<String>('getDateFormat');
  }

  /// Invokes "getMediumDateFormat" method on system_date_time_format [methodChannel]
  /// returning mediumDateFormat
  @override
  Future<String?> getMediumDatePattern() {
    return methodChannel.invokeMethod<String>('getMediumDateFormat');
  }

  /// Invokes "getLongDateFormat" method on system_date_time_format [methodChannel]
  /// returning longDateFormat
  @override
  Future<String?> getLongDatePattern() {
    return methodChannel.invokeMethod<String>('getLongDateFormat');
  }

  /// Invokes "getFullDateFormat" method on system_date_time_format [methodChannel]
  /// returning fullDateFormat
  @override
  Future<String?> getFullDatePattern() {
    return methodChannel.invokeMethod<String>('getFullDateFormat');
  }

  /// Invokes "getTimeFormat" method on system_date_time_format [methodChannel]
  /// returning timeFormat
  @override
  Future<String?> getTimePattern() {
    return methodChannel.invokeMethod<String>('getTimeFormat');
  }
}
