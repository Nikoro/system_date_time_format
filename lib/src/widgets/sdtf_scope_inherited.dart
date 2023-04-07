import 'package:flutter/material.dart';
import 'package:system_date_time_format/src/patterns.dart';

class SDTFScopeInherited extends InheritedWidget {
  const SDTFScopeInherited({
    required this.patterns,
    required super.child,
    super.key,
  });

  final Patterns patterns;

  @override
  bool updateShouldNotify(SDTFScopeInherited oldWidget) {
    return patterns != oldWidget.patterns;
  }
}
