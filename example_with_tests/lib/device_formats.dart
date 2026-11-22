import 'package:system_date_time_format/system_date_time_format.dart';

/// The example app's dependency on the device's format settings.
class DeviceFormats {
  const DeviceFormats();

  String? get shortDate => SystemDateTimeFormat.datePattern;
  String? get mediumDate => SystemDateTimeFormat.mediumDatePattern;
  String? get longDate => SystemDateTimeFormat.longDatePattern;
  String? get fullDate => SystemDateTimeFormat.fullDatePattern;
  String? get time => SystemDateTimeFormat.timePattern;
}
