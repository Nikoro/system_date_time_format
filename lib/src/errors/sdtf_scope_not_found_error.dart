import 'package:system_date_time_format/src/widgets/sdtf_scope.dart';

/// The error that will be thrown if [SystemDateTimeFormat.of] fails to find a [SDTFScope]
/// as an ancestor of the [BuildContext] used.
class SDTFScopeNotFoundError extends Error {
  /// Create a SDTFScopeNotFound error with the type represented as a String.
  SDTFScopeNotFoundError(this.widgetType);

  /// The type of the Widget requesting the value
  final Type widgetType;

  @override
  String toString() {
    return '''
Error: Could not find the SDTFScope above this $widgetType Widget

This happens because you used a `BuildContext` that does not include the SDTFScope.

if you want to use: 

SystemDateTimeFormat.of(context)

you have to wrap your root Widget e.g. App() in SDTFScope
''';
  }
}
