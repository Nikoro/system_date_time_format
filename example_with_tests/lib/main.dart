import 'package:flutter/material.dart';
import 'package:system_date_time_format/system_date_time_format.dart';
import 'package:system_date_time_format_example_with_tests/fallbacks.dart';
import 'package:system_date_time_format_example_with_tests/widgets/widgets.dart';

void main() {
  runApp(const SDTFScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final patterns = SystemDateTimeFormat.of(context);

    final datePattern = patterns.datePattern ?? Fallbacks.datePattern;
    final mediumDatePattern =
        patterns.mediumDatePattern ?? Fallbacks.mediumDatePattern;
    final longDatePattern =
        patterns.longDatePattern ?? Fallbacks.longDatePattern;
    final timePattern = patterns.timePattern ?? Fallbacks.timePattern;

    final rows = {
      'System short date format pattern:': datePattern,
      'System medium date format pattern:': mediumDatePattern,
      'System long date format pattern:': longDatePattern,
      'System time format pattern:': timePattern,
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
