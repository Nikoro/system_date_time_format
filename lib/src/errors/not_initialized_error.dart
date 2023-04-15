/// Error that will be thrown when trying to use a plugin before initialization.
class NotInitializedError extends Error {
  NotInitializedError(this.name);

  final String name;

  @override
  String toString() {
    return '$name was called before initialization\n\n\nDid you forget to call:\n\nSystemDateTimeFormat().initialize()\n\n';
  }
}
