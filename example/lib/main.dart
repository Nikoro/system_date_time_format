import 'dart:async';

import 'package:flutter/material.dart';
import 'package:system_date_time_format/system_date_time_format.dart';
import 'package:system_date_time_format_example/widgets/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemDateTimeFormat().initialize();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final formats = {
      'System date format:': SystemDateTimeFormat().dateFormat,
      'System medium date format:': SystemDateTimeFormat().mediumDateFormat,
      'System long date format:': SystemDateTimeFormat().longDateFormat,
      'System time format:': SystemDateTimeFormat().timeFormat,
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
