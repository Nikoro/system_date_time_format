part of 'extensions.dart';

extension IterableExtensions<E> on Iterable<E> {
  E get second => elementAt(1);

  E get third => elementAt(2);
}
