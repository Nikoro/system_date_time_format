import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_date_time_format/src/errors/not_ititialized_error.dart';
import 'package:system_date_time_format/src/errors/sdtf_scope_not_found_error.dart';
import 'package:system_date_time_format/src/fallbacks.dart';
import 'package:system_date_time_format/src/patterns.dart';
import 'package:system_date_time_format/src/widgets/sdtf_scope_inherited.dart';

import 'src/system_date_time_format_platform_interface.dart';

export 'src/patterns.dart';
export 'src/widgets/sdtf_scope.dart';

/// Provides date and time format from device system settings.
class SystemDateTimeFormat {
  SystemDateTimeFormat._();

  /// Factory for creating an instance of [SystemDateTimeFormat].
  factory SystemDateTimeFormat() => _instance;
  static final SystemDateTimeFormat _instance = SystemDateTimeFormat._();

  /// Returns a short version of date pattern.
  /// May throw [PlatformException] from [MethodChannel].
  Future<String?> getDatePattern() {
    return SystemDateTimeFormatPlatformInterface.instance.getDatePattern();
  }

  /// Returns a medium version of date pattern.
  /// May throw [PlatformException] from [MethodChannel].
  Future<String?> getMediumDatePattern() {
    return SystemDateTimeFormatPlatformInterface.instance
        .getMediumDatePattern();
  }

  /// Returns a long version of date pattern.
  /// May throw [PlatformException] from [MethodChannel].
  Future<String?> getLongDatePattern() {
    return SystemDateTimeFormatPlatformInterface.instance.getLongDatePattern();
  }

  /// Returns time pattern.
  /// May throw [PlatformException] from [MethodChannel].
  Future<String?> getTimePattern() {
    return SystemDateTimeFormatPlatformInterface.instance.getTimePattern();
  }

  /// Returns all available date & time patterns.
  /// May throw [PlatformException] from [MethodChannel].
  Future<Patterns> getAllPatterns() async {
    return Patterns(
      datePattern: await getDatePattern(),
      mediumDatePattern: await getMediumDatePattern(),
      longDatePattern: await getLongDatePattern(),
      timePattern: await getTimePattern(),
    );
  }

  static Patterns of(BuildContext context) {
    final sDTFScope =
        context.dependOnInheritedWidgetOfExactType<SDTFScopeInherited>();
    if (sDTFScope == null) {
      throw SDTFScopeNotFoundError(context.widget.runtimeType);
    }

    return sDTFScope.patterns;
  }

  /// Initializes the plugin.
  /// Call this method before using the plugin further.
  @Deprecated("Use SDTFScope instead.")
  Future<void> initialize({
    String dateFormatFallback = Fallbacks.dateFormat,
    String mediumDateFormatFallback = Fallbacks.mediumDateFormat,
    String longDateFormatFallback = Fallbacks.longDateFormat,
    String timeFormatFallback = Fallbacks.timeFormat,
  }) async {
    final platform = SystemDateTimeFormatPlatformInterface.instance;
    _dateFormat = await _try(
      platform.getDatePattern,
      fallback: dateFormatFallback,
    );
    _mediumDateFormat = await _try(
      platform.getMediumDatePattern,
      fallback: mediumDateFormatFallback,
    );
    _longDateFormat = await _try(
      platform.getLongDatePattern,
      fallback: longDateFormatFallback,
    );
    _timeFormat = await _try(
      platform.getTimePattern,
      fallback: timeFormatFallback,
    );
  }

  /// Returns a short version of date format.
  /// Throws [NotInitializedError] when plugin was not initialized
  @Deprecated("Use getDatePattern() instead.")
  String get dateFormat {
    if (_dateFormat == null) {
      throw NotInitializedError('dateFormat');
    }
    return _dateFormat!;
  }

  /// Returns a medium version of date format.
  /// Throws [NotInitializedError] when plugin was not initialized
  @Deprecated("Use getMediumDatePattern() instead.")
  String get mediumDateFormat {
    if (_mediumDateFormat == null) {
      throw NotInitializedError('mediumDateFormat');
    }
    return _mediumDateFormat!;
  }

  /// Returns a long version of date format.
  /// Throws [NotInitializedError] when plugin was not initialized
  @Deprecated("Use getLongDatePattern() instead.")
  String get longDateFormat {
    if (_longDateFormat == null) {
      throw NotInitializedError('longDateFormat');
    }
    return _longDateFormat!;
  }

  /// Returns time format.
  /// Throws [NotInitializedError] when plugin was not initialized
  @Deprecated("Use getTimePattern() instead.")
  String get timeFormat {
    if (_timeFormat == null) {
      throw NotInitializedError('timeFormat');
    }
    return _timeFormat!;
  }

  /// Helper function for catching [PlatformException] and returning a fallback when that happen
  Future<String> _try(
    Future<String?> Function() function, {
    required String fallback,
  }) async {
    try {
      return await function() ?? fallback;
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
