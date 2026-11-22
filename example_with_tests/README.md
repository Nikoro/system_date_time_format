# Testing an app that reads system date and time formats

`App` reads formats through an app-owned `DeviceFormats` object. Its production getters forward to the static `SystemDateTimeFormat` API. In widget tests, the constructor accepts a mock of `DeviceFormats`, so the test controls the locale patterns and can return `null` for unavailable styles.

Run `flutter test` from this directory. The tests check the label for each pattern and the app's fallback behavior. [Production adapter](lib/device_formats.dart) · [Widget tests](test/app_test.dart)
