import 'package:flutter/services.dart';
import 'package:system_date_time_format/src/errors/not_ititialized_error.dart';
import 'package:system_date_time_format/src/fallbacks.dart';

import 'src/system_date_time_format_platform_interface.dart';

/// Provides date and time format from device system settings.
class SystemDateTimeFormat {
  SystemDateTimeFormat._();

  /// Factory for creating an instance of [SystemDateTimeFormat].
  factory SystemDateTimeFormat() => _instance;
  static final SystemDateTimeFormat _instance = SystemDateTimeFormat._();

  /// Initializes the plugin.
  /// Call this method before using the plugin further.
  Future<void> initialize({
    String dateFormatFallback = Fallbacks.dateFormat,
    String mediumDateFormatFallback = Fallbacks.mediumDateFormat,
    String longDateFormatFallback = Fallbacks.longDateFormat,
    String timeFormatFallback = Fallbacks.timeFormat,
  }) async {
    final platform = SystemDateTimeFormatPlatformInterface.instance;
    _dateFormat = await _try(platform.getDateFormat, fallback: dateFormatFallback);
    _mediumDateFormat = await _try(platform.getMediumDateFormat, fallback: mediumDateFormatFallback);
    _longDateFormat = await _try(platform.getLongDateFormat, fallback: longDateFormatFallback);
    _timeFormat = await _try(platform.getTimeFormat, fallback: timeFormatFallback);
  }

  /// Returns a short version of date format.
  /// Throws [NotInitializedError] when plugin was not initialized
  String get dateFormat {
    if (_dateFormat == null) throw NotInitializedError('dateFormat');
    return _dateFormat!;
  }

  /// Returns a medium version of date format.
  /// Throws [NotInitializedError] when plugin was not initialized
  String get mediumDateFormat {
    if (_mediumDateFormat == null) throw NotInitializedError('mediumDateFormat');
    return _mediumDateFormat!;
  }

  /// Returns a long version of date format.
  /// Throws [NotInitializedError] when plugin was not initialized
  String get longDateFormat {
    if (_longDateFormat == null) throw NotInitializedError('longDateFormat');
    return _longDateFormat!;
  }

  /// Returns time format.
  /// Throws [NotInitializedError] when plugin was not initialized
  String get timeFormat {
    if (_timeFormat == null) throw NotInitializedError('timeFormat');
    return _timeFormat!;
  }

  /// Helper function for catching [PlatformException] and returning a fallback when that happen
  Future<String> _try(Future<String> Function({required String fallback}) function, {required String fallback}) async {
    try {
      return await function(fallback: fallback);
    } on PlatformException {
      return fallback;
    }
  }

  /// Holds [dateFormat] value after plugin initialization
  String? _dateFormat;

  /// Holds [mediumDateFormat] value after plugin initialization
  String? _mediumDateFormat;

  /// Holds [longDateFormat] value after plugin initialization
  String? _longDateFormat;

  /// Holds [timeFormat] value after plugin initialization
  String? _timeFormat;
}
