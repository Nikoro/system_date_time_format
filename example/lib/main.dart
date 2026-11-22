import 'package:material_ui/material_ui.dart';
import 'package:system_date_time_format/system_date_time_format.dart';
import 'package:system_date_time_format_example/fallbacks.dart';
import 'package:system_date_time_format_example/widgets/widgets.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final datePattern =
        SystemDateTimeFormat.datePattern ?? Fallbacks.datePattern;
    final mediumDatePattern =
        SystemDateTimeFormat.mediumDatePattern ?? Fallbacks.mediumDatePattern;
    final longDatePattern =
        SystemDateTimeFormat.longDatePattern ?? Fallbacks.longDatePattern;
    final fullDatePattern =
        SystemDateTimeFormat.fullDatePattern ?? Fallbacks.fullDatePattern;
    final timePattern =
        SystemDateTimeFormat.timePattern ?? Fallbacks.timePattern;

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
