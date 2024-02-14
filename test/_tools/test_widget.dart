import 'package:flutter/material.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final patterns = SystemDateTimeFormat.of(context);

    return Column(
      children: [
        Text(patterns.datePattern ?? ''),
        Text(patterns.mediumDatePattern ?? ''),
        Text(patterns.longDatePattern ?? ''),
        Text(patterns.fullDatePattern ?? ''),
        Text(patterns.timePattern ?? ''),
      ],
    );
  }
}
