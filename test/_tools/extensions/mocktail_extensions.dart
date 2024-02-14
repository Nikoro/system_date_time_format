part of 'extensions.dart';

extension WhenExtension<T> on When<T> {
  thenAnswerMany(List<Answer<T>> cbs) {
    return thenAnswer((invocation) {
      if (cbs.isEmpty) throw "No more answers available";
      return cbs.removeAt(0)(invocation);
    });
  }
}
