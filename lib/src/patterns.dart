class Patterns {
  const Patterns({
    this.datePattern,
    this.mediumDatePattern,
    this.longDatePattern,
    this.timePattern,
  });

  final String? datePattern;
  final String? mediumDatePattern;
  final String? longDatePattern;
  final String? timePattern;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Patterns &&
          runtimeType == other.runtimeType &&
          datePattern == other.datePattern &&
          mediumDatePattern == other.mediumDatePattern &&
          longDatePattern == other.longDatePattern &&
          timePattern == other.timePattern;

  @override
  int get hashCode =>
      datePattern.hashCode ^
      mediumDatePattern.hashCode ^
      longDatePattern.hashCode ^
      timePattern.hashCode;
}
