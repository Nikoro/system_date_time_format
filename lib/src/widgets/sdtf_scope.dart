import 'package:flutter/material.dart';
import 'package:system_date_time_format/src/widgets/sdtf_scope_inherited.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

class SDTFScope extends StatefulWidget {
  const SDTFScope({
    required this.child,
    @visibleForTesting this.format,
    super.key,
  });

  final Widget child;
  final SystemDateTimeFormat? format;

  @override
  State<SDTFScope> createState() => _SDTFScopeState();
}

class _SDTFScopeState extends State<SDTFScope> with WidgetsBindingObserver {
  late final SystemDateTimeFormat systemDateTimeFormat;
  Patterns patterns = const Patterns();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    systemDateTimeFormat = widget.format ?? SystemDateTimeFormat();
    _updatePatternsIfNeeded();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SDTFScopeInherited(
      patterns: patterns,
      child: widget.child,
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await _updatePatternsIfNeeded();
    }
  }

  Future<void> _updatePatternsIfNeeded() async {
    final patterns = await systemDateTimeFormat.getAllPatterns();
    if (this.patterns != patterns) {
      setState(() => this.patterns = patterns);
    }
  }
}
