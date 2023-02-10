import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'system_date_time_format_platform_interface.dart';

/// An implementation of [SystemDateTimeFormatPlatformInterface] that uses method channels.
class MethodChannelSystemDateTimeFormat extends SystemDateTimeFormatPlatformInterface {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('system_date_time_format');

  /// Invokes "getDateFormat" method on system_date_time_format [methodChannel]
  /// returning dateFormat when success
  /// otherwise a fallback value passed as an argument to this function
  @override
  Future<String> getDateFormat({required String fallback}) async {
    final dateFormat = await methodChannel.invokeMethod<String>('getDateFormat');
    return dateFormat ?? fallback;
  }

  /// Invokes "getMediumDateFormat" method on system_date_time_format [methodChannel]
  /// returning mediumDateFormat when success
  /// otherwise a fallback value passed as an argument to this function
  @override
  Future<String> getMediumDateFormat({required String fallback}) async {
    final mediumDateFormat = await methodChannel.invokeMethod<String>('getMediumDateFormat');
    return mediumDateFormat ?? fallback;
  }

  /// Invokes "getLongDateFormat" method on system_date_time_format [methodChannel]
  /// returning longDateFormat when success
  /// otherwise a fallback value passed as an argument to this function
  @override
  Future<String> getLongDateFormat({required String fallback}) async {
    final longDateFormat = await methodChannel.invokeMethod<String>('getLongDateFormat');
    return longDateFormat ?? fallback;
  }

  /// Invokes "getTimeFormat" method on system_date_time_format [methodChannel]
  /// returning timeFormat when success
  /// otherwise a fallback value passed as an argument to this function
  @override
  Future<String> getTimeFormat({required String fallback}) async {
    final timeFormat = await methodChannel.invokeMethod<String>('getTimeFormat');
    return timeFormat ?? fallback;
  }
}
