import 'dart:async';

import 'package:flutter/material.dart';
import 'package:system_date_time_format/system_date_time_format.dart';
import 'package:system_date_time_format_example_with_tests/app.dart';

import 'dependency_injection/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await getIt<SystemDateTimeFormat>().initialize();
  runApp(const App());
}
