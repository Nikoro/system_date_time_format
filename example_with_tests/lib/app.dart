import 'package:flutter/material.dart';
import 'package:system_date_time_format/system_date_time_format.dart';
import 'package:system_date_time_format_example_with_tests/dependency_injection/injection.dart';
import 'package:system_date_time_format_example_with_tests/widgets/widgets.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final systemDateTimeFormat = getIt<SystemDateTimeFormat>();
    final formats = {
      'System date format:': systemDateTimeFormat.dateFormat,
      'System medium date format:': systemDateTimeFormat.mediumDateFormat,
      'System long date format:': systemDateTimeFormat.longDateFormat,
      'System time format:': systemDateTimeFormat.timeFormat,
    };

    return MaterialApp(
      home: Scaffold(
        appBar: const Toolbar(),
        body: Body(
          children: formats.entries
              .map((e) => RowItem(title: e.key, value: e.value))
              .toList(),
        ),
      ),
    );
  }
}
