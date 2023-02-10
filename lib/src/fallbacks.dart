/// Fallback values in case of platform errors.
/// They can be overwritten on initialization of the plugin.
abstract class Fallbacks {
  Fallbacks._();

  static const dateFormat = 'M/d/yy';
  static const mediumDateFormat = 'MMM d,y';
  static const longDateFormat = 'MMMM d,y';
  static const timeFormat = 'h:mm a';
}
