import 'package:material_ui/material_ui.dart';
import 'package:system_date_time_format_example_with_tests/device_formats.dart';
import 'package:system_date_time_format_example_with_tests/fallbacks.dart';
import 'package:system_date_time_format_example_with_tests/widgets/widgets.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key, this.formats = const DeviceFormats()});

  final DeviceFormats formats;

  @override
  Widget build(BuildContext context) {
    final datePattern = formats.shortDate ?? Fallbacks.datePattern;
    final mediumDatePattern = formats.mediumDate ?? Fallbacks.mediumDatePattern;
    final longDatePattern = formats.longDate ?? Fallbacks.longDatePattern;
    final fullDatePattern = formats.fullDate ?? Fallbacks.fullDatePattern;
    final timePattern = formats.time ?? Fallbacks.timePattern;

    final rows = {
      'Short date format pattern:': datePattern,
      'Medium date format pattern:': mediumDatePattern,
      'Long date format pattern:': longDatePattern,
      'Full date format pattern:': fullDatePattern,
      'Time format pattern:': timePattern,
    };

    return MaterialApp(
      home: Scaffold(
        appBar: const Toolbar(),
        body: Body(
          children: rows.entries
              .map((e) => RowItem(title: e.key, value: e.value))
              .toList(),
        ),
      ),
    );
  }
}
