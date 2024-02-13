import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_date_time_format/src/errors/sdtf_scope_not_found_error.dart';
import 'package:system_date_time_format/src/extensions/extensions.dart';
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
  /// Available on iOS, macOS, android, web, windows and linux
  /// May throw [PlatformException] from [MethodChannel].
  Future<String?> getDatePattern() async {
    final pattern =
        await SystemDateTimeFormatPlatformInterface.instance.getDatePattern();
    return pattern.isNullOrEmpty ? null : pattern;
  }

  /// Returns a medium version of date pattern.
  /// Available on iOS, macOS, android and web
  /// May throw [PlatformException] from [MethodChannel].
  Future<String?> getMediumDatePattern() async {
    final pattern = await SystemDateTimeFormatPlatformInterface.instance
        .getMediumDatePattern();
    return pattern.isNullOrEmpty ? null : pattern;
  }

  /// Returns a long version of date pattern.
  /// Available on iOS, macOS, android, web, windows and linux
  /// May throw [PlatformException] from [MethodChannel].
  Future<String?> getLongDatePattern() async {
    final pattern = await SystemDateTimeFormatPlatformInterface.instance
        .getLongDatePattern();
    return pattern.isNullOrEmpty ? null : pattern;
  }

  /// Returns a full version of date pattern.
  /// Available on iOS, macOS and web
  /// May throw [PlatformException] from [MethodChannel].
  Future<String?> getFullDatePattern() async {
    final pattern = await SystemDateTimeFormatPlatformInterface.instance
        .getFullDatePattern();
    return pattern.isNullOrEmpty ? null : pattern;
  }

  /// Returns time pattern.
  /// Available on iOS, macOS, android, web, windows and linux
  /// May throw [PlatformException] from [MethodChannel].
  Future<String?> getTimePattern() async {
    final pattern =
        await SystemDateTimeFormatPlatformInterface.instance.getTimePattern();
    return pattern.isNullOrEmpty ? null : pattern;
  }

  /// Returns all available date & time patterns.
  /// May throw [PlatformException] from [MethodChannel].
  Future<Patterns> getAllPatterns() async {
    return Patterns(
      datePattern: await getDatePattern(),
      mediumDatePattern: await getMediumDatePattern(),
      longDatePattern: await getLongDatePattern(),
      fullDatePattern: await getFullDatePattern(),
      timePattern: await getTimePattern(),
    );
  }

  static Patterns of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<SDTFScopeInherited>();
    if (scope == null) {
      throw SDTFScopeNotFoundError(context.widget.runtimeType);
    }

    return scope.patterns;
  }
}
