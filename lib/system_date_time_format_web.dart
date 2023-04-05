@JS()
library system_date_time_format_web;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';
import 'package:system_date_time_format/src/system_date_time_format_platform_interface.dart';

@JS('getDateFormat')
external String _getDateFormat();

@JS('getLongDateFormat')
external String _getLongDateFormat();

@JS('getMediumDateFormat')
external String _getMediumDateFormat();

@JS('getTimeFormat')
external String _getTimeFormat();

/// A web implementation of the SystemDateTimeFormatPlatformInterface of the SystemDateTimeFormat plugin.
class SystemDateTimeFormatWeb extends SystemDateTimeFormatPlatformInterface {
  /// Constructs a SystemDateTimeFormatWeb
  SystemDateTimeFormatWeb();

  static void registerWith(Registrar registrar) {
    SystemDateTimeFormatPlatformInterface.instance = SystemDateTimeFormatWeb();
  }

  /// Returns a short version of date format.
  @override
  Future<String> getDateFormat() async {
    return _getDateFormat();
  }

  /// Returns a medium version of date format.
  @override
  Future<String> getMediumDateFormat() async {
    return _getMediumDateFormat();
  }

  /// Returns a long version of date format.
  @override
  Future<String> getLongDateFormat() async {
    return _getLongDateFormat();
  }

  /// Returns time format.
  @override
  Future<String> getTimeFormat() async {
    return _getTimeFormat();
  }
}
