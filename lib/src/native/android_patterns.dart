import 'package:jni/jni.dart';
import 'package:jni_flutter/jni_flutter.dart';

import 'pattern_kind.dart';

final _androidDateFormat = JClass.forName('android/text/format/DateFormat');
final _javaDateFormat = JClass.forName('java/text/DateFormat');
final _simpleDateFormat = JClass.forName('java/text/SimpleDateFormat');
final _context = JClass.forName('android/content/Context');
final _resources = JClass.forName('android/content/res/Resources');
final _configuration = JClass.forName('android/content/res/Configuration');

const _androidFormatSignature =
    '(Landroid/content/Context;)Ljava/text/DateFormat;';
final _getDateFormat = _androidDateFormat.staticMethodId(
  'getDateFormat',
  _androidFormatSignature,
);
final _getMediumDateFormat = _androidDateFormat.staticMethodId(
  'getMediumDateFormat',
  _androidFormatSignature,
);
final _getLongDateFormat = _androidDateFormat.staticMethodId(
  'getLongDateFormat',
  _androidFormatSignature,
);
final _getTimeFormat = _androidDateFormat.staticMethodId(
  'getTimeFormat',
  _androidFormatSignature,
);
final _getDateInstance = _javaDateFormat.staticMethodId(
  'getDateInstance',
  '(ILjava/util/Locale;)Ljava/text/DateFormat;',
);
final _fullStyle = _javaDateFormat.staticFieldId('FULL', 'I');
final _getResources = _context.instanceMethodId(
  'getResources',
  '()Landroid/content/res/Resources;',
);
final _getConfiguration = _resources.instanceMethodId(
  'getConfiguration',
  '()Landroid/content/res/Configuration;',
);
final _locale = _configuration.instanceFieldId('locale', 'Ljava/util/Locale;');
final _toLocalizedPattern = _simpleDateFormat.instanceMethodId(
  'toLocalizedPattern',
  '()Ljava/lang/String;',
);

String? readAndroidPattern(PatternKind kind) => using((arena) {
  final context = androidApplicationContext..releasedBy(arena);
  final formatter = switch (kind) {
    PatternKind.date => _getDateFormat(_androidDateFormat, JObject.type, [
      context,
    ]),
    PatternKind.mediumDate => _getMediumDateFormat(
      _androidDateFormat,
      JObject.type,
      [context],
    ),
    PatternKind.longDate => _getLongDateFormat(
      _androidDateFormat,
      JObject.type,
      [context],
    ),
    PatternKind.fullDate => _getFullDateFormat(context, arena),
    PatternKind.time => _getTimeFormat(_androidDateFormat, JObject.type, [
      context,
    ]),
  }..releasedBy(arena);
  if (!formatter.isInstanceOf(_simpleDateFormat)) return null;

  final pattern = _toLocalizedPattern(formatter, JString.type, [])
    ..releasedBy(arena);
  return pattern.toDartString();
});

JObject _getFullDateFormat(JObject context, Arena arena) {
  final resources = _getResources(context, JObject.type, [])..releasedBy(arena);
  final configuration = _getConfiguration(resources, JObject.type, [])
    ..releasedBy(arena);
  final locale = _locale.get(configuration, JObject.type)..releasedBy(arena);
  final style = _fullStyle.get(_javaDateFormat, jint.type);
  return _getDateInstance(_javaDateFormat, JObject.type, [style, locale]);
}
