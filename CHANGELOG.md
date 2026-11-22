## [2.0.0] - 2026-11-22

### Changed

- **Breaking:** Date and time formats are available through synchronous static getters such as `SystemDateTimeFormat.datePattern`.
- **Breaking:** Removed the `SystemDateTimeFormat` constructor, the asynchronous methods, `Patterns`, `SDTFScope`, and `SystemDateTimeFormat.of(context)`.
- Regenerated both example apps with the Flutter 3.50 template.

### Fixed

- Web patterns no longer change with the current day, month, or time. Date styles preserve numeric padding, abbreviated and full month names, and quoted literal words.
- Linux `longDatePattern` now returns the ICU long date for the active `LC_TIME` locale. Linux builds require ICU development headers and libraries (`libicu-dev` on Debian and Ubuntu).
- Windows converts weekday and day-period fields to Dart `intl` syntax while preserving quoted text and escaped apostrophes.

### Migrating an app from 1.x

1. **Find callers and tests.** Run the search below from the consuming repository root. Include local packages, dependency injection registrations, handwritten mocks and mock generator annotations. Use the Dart analyzer to catch references through import aliases and re-exports.

   ```sh
   rg -n --type dart 'system_date_time_format|SystemDateTimeFormat|SDTFScope|\bPatterns\b|getAllPatterns|get(MediumDate|LongDate|FullDate|Date|Time)Pattern'
   ```

2. **Replace each read.** All five getters return `String?` synchronously. Keep application fallbacks and null checks. The medium and full date styles return `null` on Windows and Linux.

   | 1.x instance method | New static getter |
   | --- | --- |
   | `getDatePattern()` | `SystemDateTimeFormat.datePattern` |
   | `getMediumDatePattern()` | `SystemDateTimeFormat.mediumDatePattern` |
   | `getLongDatePattern()` | `SystemDateTimeFormat.longDatePattern` |
   | `getFullDatePattern()` | `SystemDateTimeFormat.fullDatePattern` |
   | `getTimePattern()` | `SystemDateTimeFormat.timePattern` |

   For example, `(await format.getAllPatterns()).timePattern ?? fallback` becomes `SystemDateTimeFormat.timePattern ?? fallback`. Read each required field once into a local variable if the old code reused the result.

3. **Remove obsolete plumbing.** Remove the plugin constructor, `getAllPatterns()`, and uses of the package's `Patterns` type. Replace `SystemDateTimeFormat.of(context).datePattern` with `SystemDateTimeFormat.datePattern` and unwrap `SDTFScope(child: app)` to `app`. Remove `await`, `.then(...)`, `FutureBuilder` or a surrounding `async` only where it existed solely for these reads. Preserve asynchronous contracts that other callers still depend on.

4. **Preserve any refresh behavior your screen needs.** The old scope refreshed its descendants on app resume. A static getter reads current settings when called. For a visible screen that must refresh after a settings change, rebuild it on resume (for example with a state-owned `AppLifecycleListener` whose `onResume` calls `setState`). Read the getter in `build` and dispose the listener in `dispose`.

5. **Move test doubles to the consumer.** Replace mocks of `SystemDateTimeFormat` and mock method-channel handlers with injected values, callbacks, or an app-owned reader. Stub synchronous answers on that reader, for example `when(() => formats.time).thenReturn('HH:mm')`. Check both a known pattern and a `null` fallback. Regenerate generated mocks if your project uses them. [Working widget test](example_with_tests/test/app_test.dart)

6. **Verify the migration.** Use the intended package release or local path in the consuming app, run `flutter pub get`, `flutter analyze` and `flutter test`, and build the targets the app ships. For Linux, install the ICU development package on the builder and include the matching ICU runtime dependency when distributing the app. For web, keep the package's JavaScript asset loaded before Flutter starts. If the app previously used scope-based refresh, change the device's clock preference, return to the app, and verify that the visible time format updates.

## [1.5.1] - 2026-08-05

### Fixed

- Fixed `SDTFScope` throwing an unhandled exception when it was disposed while a pending date/time format request was still in flight.

## [1.5.0] - 2026-05-27

### Added

- Migrated platform build configurations to current Flutter tooling.

## 1.4.0

- Added Swift Package Manager support for iOS and macOS platforms

## 1.3.1

- Updated documentation to recommend using local web asset instead of CDN from v1.3.1+
- Added web asset to pubspec.yaml for better offline support
- Updated example projects to use local web asset
- Excluded example directories from analyzer

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
