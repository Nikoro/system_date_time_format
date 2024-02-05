import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_date_time_format/src/errors/sdtf_scope_not_found_error.dart';
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
}
