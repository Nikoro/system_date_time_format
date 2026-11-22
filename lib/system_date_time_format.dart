import 'src/extensions/extensions.dart';
import 'src/system_date_time_format_platform_interface.dart';

/// Reads date and time format patterns from the current device settings.
abstract final class SystemDateTimeFormat {
  /// The short date pattern, or null if unavailable.
  static String? get datePattern {
    final pattern = SystemDateTimeFormatPlatformInterface.instance
        .getDatePattern();
    return pattern.isNullOrEmpty ? null : pattern;
  }

  /// The medium date pattern. Returns null on Windows and Linux.
  static String? get mediumDatePattern {
    final pattern = SystemDateTimeFormatPlatformInterface.instance
        .getMediumDatePattern();
    return pattern.isNullOrEmpty ? null : pattern;
  }

  /// The long date pattern, or null if unavailable.
  static String? get longDatePattern {
    final pattern = SystemDateTimeFormatPlatformInterface.instance
        .getLongDatePattern();
    return pattern.isNullOrEmpty ? null : pattern;
  }

  /// The full date pattern. Returns null on Windows and Linux.
  static String? get fullDatePattern {
    final pattern = SystemDateTimeFormatPlatformInterface.instance
        .getFullDatePattern();
    return pattern.isNullOrEmpty ? null : pattern;
  }

  /// The time pattern, or null if unavailable.
  static String? get timePattern {
    final pattern = SystemDateTimeFormatPlatformInterface.instance
        .getTimePattern();
    return pattern.isNullOrEmpty ? null : pattern;
  }
}
