/// Fallback values in case of platform errors.
/// They can be overwritten on initialization of the plugin.
abstract class Fallbacks {
  Fallbacks._();

  static const datePattern = 'M/d/yy';
  static const mediumDatePattern = 'MMM d,y';
  static const longDatePattern = 'MMMM d,y';
  static const timePattern = 'h:mm a';
}
