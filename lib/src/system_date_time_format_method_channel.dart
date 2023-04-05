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
  Future<String?> getDateFormat() {
    return methodChannel.invokeMethod<String>('getDateFormat');
  }

  /// Invokes "getMediumDateFormat" method on system_date_time_format [methodChannel]
  /// returning mediumDateFormat
  @override
  Future<String?> getMediumDateFormat() {
    return methodChannel.invokeMethod<String>('getMediumDateFormat');
  }

  /// Invokes "getLongDateFormat" method on system_date_time_format [methodChannel]
  /// returning longDateFormat
  @override
  Future<String?> getLongDateFormat() {
    return methodChannel.invokeMethod<String>('getLongDateFormat');
  }

  /// Invokes "getTimeFormat" method on system_date_time_format [methodChannel]
  /// returning timeFormat
  @override
  Future<String?> getTimeFormat() {
    return methodChannel.invokeMethod<String>('getTimeFormat');
  }
}
