import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'android_patterns.dart';
import 'pattern_kind.dart';
import 'windows_pattern.dart';

String? readPattern(PatternKind kind) {
  if (Platform.isAndroid) return readAndroidPattern(kind);

  final pattern = _getPattern(kind.index);
  if (pattern == nullptr) return null;

  try {
    final value = pattern.toDartString();
    return Platform.isWindows ? convertWindowsPattern(value) : value;
  } finally {
    _freePattern(pattern);
  }
}

@Native<Pointer<Utf8> Function(Int32)>(symbol: 'sdtf_get_pattern')
external Pointer<Utf8> _getPattern(int kind);

@Native<Void Function(Pointer<Utf8>)>(symbol: 'sdtf_free_pattern')
external void _freePattern(Pointer<Utf8> pattern);
