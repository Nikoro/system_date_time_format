import 'dart:async';

import 'package:flutter/material.dart';
import 'package:system_date_time_format/system_date_time_format.dart';
import 'package:system_date_time_format_example/fallbacks.dart';
import 'package:system_date_time_format_example/widgets/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final format = SystemDateTimeFormat();

  final datePattern = await format.getDatePattern();
  final mediumDatePattern = await format.getMediumDatePattern();
  final longDatePattern = await format.getLongDatePattern();
  final timePattern = await format.getTimePattern();

  runApp(App(
    datePattern: datePattern,
    mediumDatePattern: mediumDatePattern,
    longDatePattern: longDatePattern,
    timePattern: timePattern,
  ));
}

class App extends StatelessWidget {
  const App({
    this.datePattern,
    this.mediumDatePattern,
    this.longDatePattern,
    this.timePattern,
    super.key,
  });

  final String? datePattern;
  final String? mediumDatePattern;
  final String? longDatePattern;
  final String? timePattern;

  @override
  Widget build(BuildContext context) {
    final patterns = {
      'System short date format pattern:': datePattern ?? Fallbacks.datePattern,
      'System medium date format pattern:':
          mediumDatePattern ?? Fallbacks.mediumDatePattern,
      'System long date format pattern:':
          longDatePattern ?? Fallbacks.longDatePattern,
      'System time format pattern:': timePattern ?? Fallbacks.timePattern,
    };

    return MaterialApp(
      home: Scaffold(
        appBar: const Toolbar(),
        body: Body(
          children: patterns.entries
              .map((e) => RowItem(title: e.key, value: e.value))
              .toList(),
        ),
      ),
    );
  }
}
