# SystemDateTimeFormat

<h2 align="center">
  A plugin for getting date & time format from device system settings.
</h2>

<p align="center">
  <a href="https://pub.dev/packages/system_date_time_format">
    <img alt="Pub Package" src="https://tinyurl.com/2na5mvwt">
  </a>
  <a href="https://github.com/Nikoro/system_date_time_format/actions">
    <img alt="Build Status" src="https://github.com/Nikoro/system_date_time_format/actions/workflows/build.yaml/badge.svg">
  </a>
  <a href="https://codecov.io/gh/Nikoro/system_date_time_format">
    <img alt="Code Coverage" src="https://codecov.io/gh/Nikoro/system_date_time_format/branch/main/graph/badge.svg">
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img alt="MIT License" src="https://tinyurl.com/3uf9tzpy">
  </a>
    <img alt="Android support ✓" src="https://img.shields.io/badge/%E2%9C%93-grey?logo=android">
    <img alt="iOS support ✓" src="https://img.shields.io/badge/%E2%9C%93-grey?logo=ios">
    <img alt="macOS support ✓" src="https://tinyurl.com/kka6pu4c">
    <img alt="windows support ✓" src="https://img.shields.io/badge/%E2%9C%93-grey?logo=windows">
    <img alt="web support ✓" src="https://img.shields.io/badge/web%20%E2%9C%93-grey">
    <img alt="linux support soon..." src="https://img.shields.io/badge/%20soon...-grey?logo=linux">
</p>

---
## Why system_date_time_format?

Flutter does not support retrieving date and time format patterns based on the user's system
settings out of the box. However, you can use the `system_date_time_format` plugin to get 
date and time format patterns for consistent formatting in your Flutter app.

### Examples
| iOS (Region: United States 🇺🇸)                                                                                 | Result                                                                                                        |
| -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| ![ios_setup](https://github.com/Nikoro/system_date_time_format/blob/main/screenshots/ios_setup.jpg)            | ![ios_result](https://github.com/Nikoro/system_date_time_format/blob/main/screenshots/ios_result.jpg)         |

| Android (Region: United Kingdom 🇬🇧)                                                                            | Result                                                                                                        |
| -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| ![android_setup](https://github.com/Nikoro/system_date_time_format/blob/main/screenshots/android_setup.jpg)    | ![android_result](https://github.com/Nikoro/system_date_time_format/blob/main/screenshots/android_result.jpg) |

| macOS (Region: Poland 🇵🇱)                                                                                      | Result                                                                                                        |
| -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| ![macos_setup](https://github.com/Nikoro/system_date_time_format/blob/main/screenshots/macos_setup.png)        | ![macos_result](https://github.com/Nikoro/system_date_time_format/blob/main/screenshots/macos_result.png)     |

| windows (Region: United States 🇺🇸)                                                                             | Result                                                                                                        |
| -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| ![windows_setup](https://github.com/Nikoro/system_date_time_format/blob/main/screenshots/windows_setup.jpg)    | ![windows_result](https://github.com/Nikoro/system_date_time_format/blob/main/screenshots/windows_result.jpg) |

| web (Region: Poland 🇵🇱)                                                                                                                                                                                                         |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![web_result](https://github.com/Nikoro/system_date_time_format/blob/main/screenshots/web_result.png)                                                                                                                          

## Usage

Import `import 'package:system_date_time_format/system_date_time_format.dart';`,   
initialize `SystemDateTimeFormat` and use getters to get date & time formats from device system.

Example:

```dart
import 'package:system_date_time_format/system_date_time_format.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemDateTimeFormat().initialize();
  runApp(const App());
}
```

> **Note**
>
> Don't forget to call `initialize()` before accessing any getters:
> 
> `dateFormat`, `mediumDateFormat`, `longDateFormat`, `timeFormat`  
> 
> otherwise it will throw `NotInitializedError`.

```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemDateTimeFormat() is a Singleton
    final dateFormat = SystemDateTimeFormat().dateFormat;
    final timeFormat = SystemDateTimeFormat().timeFormat;

    print(dateFormat); // e.g. "M/d/yy"
    print(timeFormat); // e.g. "HH:mm"

    return const MaterialApp(
      home: Scaffold(),
    );
  }
}
```

### Web

In order to use this plugin on web app you need to add `system_date_time_format.js` script to your `index.html`:
```html
<src="https://cdn.jsdelivr.net/gh/Nikoro/system_date_time_format@main/web/system_date_time_format.js"></script>
```
index.html

```html
<!DOCTYPE html>
<html>
<head>
    <!--...-->
    <src="https://cdn.jsdelivr.net/gh/Nikoro/system_date_time_format@main/web/system_date_time_format.js"></script>
</head>
<body>
<!--...-->
</body>
</html>
```

### Fallbacks

In case of some error, e.g. `PlatformException` plugin will return
[fallback values](https://github.com/Nikoro/system_date_time_format/blob/main/lib/src/fallbacks.dart)
.  
You can setup your own values by passing them in the `initialize()`:

```dart
SystemDateTimeFormat().initialize(
  dateFormatFallback: // default: 'M/d/yy'
  mediumDateFormatFallback: // default: 'MMM d,y'
  longDateFormatFallback: // default: 'MMMM d,y'
  timeFormatFallback: // default: 'h:mm a'
);
```

### Testing

As the plugin class is not static, it is possible to mock and verify its behaviour when writing
tests as part of your application.  
Check the source code
of [example_with_tests](https://github.com/Nikoro/system_date_time_format/tree/main/example_with_tests)
which is a modification of
basic [example](https://github.com/Nikoro/system_date_time_format/tree/main/example)  
with dependency injection using [get_it](https://pub.dev/packages/get_it) and mocks thanks
to [mocktail](https://pub.dev/packages/mocktail).