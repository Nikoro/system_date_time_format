part of 'extensions.dart';

extension FunctionExtensions on Function {
  String get name {
    final regExp = RegExp(r"(?<=')(.*?)(?=')");

    return regExp.firstMatch(toString())?.group(0) ?? '';
  }
}
