## 1.3.0

- **BREAKING**: Updated minimum Dart SDK to 3.2.0 (from 2.18.6) and Flutter SDK to 3.16.0 (from 2.5.0)
- Removed js_interop package dependency (now using built-in dart:js_interop)
- Fixed AM/PM pattern conversion from 'tt' to 'a' on Windows and Linux platforms
- Fixed hour pattern formatting on web platform

## 1.2.2

- Added WASM compatibility
- Update dependencies

## 1.2.1

- Fix bug on android:
> A problem occurred configuring project ':system_date_time_format'.
> Could not create an instance of type com.android.build.api.variant.impl.LibraryVariantBuilderImpl.
> Namespace not specified. Specify a namespace in the module's build file. See https://d.android.com/r/tools/upgrade-assistant/set-namespace for information about setting the namespace.
- Update dependencies

## 1.2.0

Added `full date pattern` for android

## 1.1.2

- Updated README info about -> [`system_date_time_format_hook`](https://pub.dev/packages/system_date_time_format_hook) package
- Improved tests

## 1.1.1

Refactor deprecated methods in tests

## 1.1.0

- Added `full date pattern` (only available for iOS, macOS and web)
- Fix returning empty string `""` instead of `null` on windows & linux when pattern is unavailable

## 1.0.0

**BREAKING CHANGES**:
>
> Removed `initialize` method -> use `SDTFScope` instead
>
> Removed `dateFormat` getter -> use `getDatePattern()` instead
>
> Removed `mediumDateFormat` getter -> use `getMediumDatePattern()` instead
>
> Removed `longDateFormat` getter -> use `getLongDatePattern()` instead
>
> Removed `timeFormat` getter -> use `getTimePattern()` instead

## 0.7.2

Updated the SDK constraint to '>=2.18.6 <4.0.0'

## 0.7.1

- Fixed attachments in [README](https://github.com/Nikoro/system_date_time_format/blob/main/README.md)
- Fixed typos
- Updated dependencies

## 0.7.0

Added logo

## 0.6.1

Fixed deprecated usage in comments

## 0.6.0

- Introduced `SDTFScope` widget:
```dart
void main() {
  runApp(const SDTFScope(child: App()));
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final patterns = SystemDateTimeFormat.of(context);

    final datePattern = patterns.datePattern;
    final mediumDatePattern = patterns.mediumDatePattern;
    final longDatePattern = patterns.longDatePattern;
    final timePattern = patterns.timePattern;

    print(datePattern); // e.g. "M/d/yy"
    print(mediumDatePattern); // e.g. "MMM d,y"
    print(longDatePattern); // e.g. "MMMM d,y"
    print(timePattern); // e.g. "HH:mm"
  }
}
```
- Introduced raw async getters:
```dart
final format = SystemDateTimeFormat();

final datePattern = await format.getDatePattern();
final mediumDatePattern = await format.getMediumDatePattern();
final longDatePattern = await format.getLongDatePattern();
final timePattern = await format.getTimePattern();

print(datePattern); // e.g. "M/d/yy"
print(mediumDatePattern); // e.g. "MMM d,y"
print(longDatePattern); // e.g. "MMMM d,y"
print(timePattern); // e.g. "HH:mm"
```
> **Warning**
> 
> Deprecated `initialize` method -> use `SDTFScope` instead
> 
> Deprecated `dateFormat` getter -> use `getDatePattern()` instead
> 
> Deprecated `mediumDateFormat` getter -> use `getMediumDatePattern()` instead
> 
> Deprecated `longDateFormat` getter -> use `getLongDatePattern()` instead
> 
> Deprecated `timeFormat` getter -> use `getTimePattern()` instead

## 0.5.0

Added linux support

## 0.4.1

- Fixed library names conflict
- Improved documentation

## 0.4.0

Added web support

## 0.3.0

Added windows support

## 0.2.0

Added macOS support

## 0.1.1

- Formatted code
- Updated  [screenshots](https://github.com/Nikoro/system_date_time_format/tree/main/screenshots)
- Improved [README](https://github.com/Nikoro/system_date_time_format/blob/main/README.md)

## 0.1.0

Initial release 🎉
