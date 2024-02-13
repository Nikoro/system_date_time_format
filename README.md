<p align="center">
  <a href="https://pub.dev/packages/system_date_time_format"><img src="https://raw.githubusercontent.com/nikoro/system_date_time_format/main/logo/logo.png" width="600"/></a>
</p>
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
    <img alt="linux support ✓" src="https://img.shields.io/badge/%E2%9C%93-grey?logo=linux">
    <img alt="web support ✓" src="https://img.shields.io/badge/web%20%E2%9C%93-grey">
</p>

---
## Why system_date_time_format?

Flutter does not support retrieving date and time format patterns based on the user's system
settings out of the box. However, you can use the `system_date_time_format` plugin to get 
date and time format patterns for consistent formatting in your Flutter app with ease:

```dart
final datePattern = await SystemDateTimeFormat().getDatePattern();
print(datePattern); // e.g. "M/d/yy"
```

### Examples
| iOS (Region: United States 🇺🇸)                                                                                 | Result                                                                                                        |
| -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| ![ios_setup](https://raw.githubusercontent.com/nikoro/system_date_time_format/main/screenshots/ios_setup.jpg)            | ![ios_result](https://raw.githubusercontent.com/nikoro/system_date_time_format/main/screenshots/ios_result.jpg)         |

| Android (Region: United Kingdom 🇬🇧)                                                                            | Result                                                                                                        |
| -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| ![android_setup](https://raw.githubusercontent.com/nikoro/system_date_time_format/main/screenshots/android_setup.jpg)    | ![android_result](https://raw.githubusercontent.com/nikoro/system_date_time_format/main/screenshots/android_result.jpg) |

| macOS (Region: Poland 🇵🇱)                                                                                      | Result                                                                                                        |
| -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| ![macos_setup](https://raw.githubusercontent.com/nikoro/system_date_time_format/main/screenshots/macos_setup.png)        | ![macos_result](https://raw.githubusercontent.com/nikoro/system_date_time_format/main/screenshots/macos_result.png)     |

| windows (Region: United States 🇺🇸)                                                                             | Result                                                                                                        |
| -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| ![windows_setup](https://raw.githubusercontent.com/nikoro/system_date_time_format/main/screenshots/windows_setup.jpg)    | ![windows_result](https://raw.githubusercontent.com/nikoro/system_date_time_format/main/screenshots/windows_result.jpg) |

| linux (Region: United States 🇺🇸)                                                                      | Result                                                                                                    |
|---------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| ![linux_setup](https://raw.githubusercontent.com/nikoro/system_date_time_format/main/screenshots/linux_setup.png) | ![linux_result](https://raw.githubusercontent.com/nikoro/system_date_time_format/main/screenshots/linux_result.png) |

| web (Region: Poland 🇵🇱)                                                                                                                                                                                                         |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![web_result](https://raw.githubusercontent.com/nikoro/system_date_time_format/main/screenshots/web_result.png)

## Usage

Import `import 'package:system_date_time_format/system_date_time_format.dart';`,   
and use getters to get date & time format patterns from device system.

Example:

```dart
import 'package:system_date_time_format/system_date_time_format.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final format = SystemDateTimeFormat();

  final datePattern = await format.getDatePattern();
  final mediumDatePattern = await format.getMediumDatePattern();
  final longDatePattern = await format.getLongDatePattern();
  final fullDatePattern = await format.getFullDatePattern(); // available only on iOS, macOS and web
  final timePattern = await format.getTimePattern();

  print(datePattern); // e.g. "M/d/yy"
  print(mediumDatePattern); // e.g. "MMM d,y"
  print(longDatePattern); // e.g. "MMMM d,y"
  print(fullDatePattern); // e.g. "EEEE, MMMM d, y"
  print(timePattern); // e.g. "HH:mm"
}
```

### SDTFScope
You can use raw async getters like in the example above (and handle asynchronus operations by yourself) or 
you can use convenient `SDTFScope` widget for handling these for you.

Simply wrap your root widget in `SDTFScope`:
```dart
void main() {
  runApp(const SDTFScope(child: App()));
}
```
then you can get the date & time patterns down in the widget tree using BuildContext:
```dart
final patterns = SystemDateTimeFormat.of(context);
```
Example:
```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final patterns = SystemDateTimeFormat.of(context);

    final datePattern = patterns.datePattern;
    final timePattern = patterns.timePattern;

    print(datePattern); // e.g. "M/d/yy"
    print(timePattern); // e.g. "HH:mm"

    return const MaterialApp(
      home: Scaffold(),
    );
  }
}
```
> **Note**
>
> `SDTFScope` will automatically sync date & time format patterns even if user changes them 
> in the device system settings while your app is running.

### Web

In order to use this plugin on web app you need to add `system_date_time_format.js` script to your `index.html`:
```html
<src="https://cdn.jsdelivr.net/gh/Nikoro/system_date_time_format@main/web/system_date_time_format.min.js"></script>
```
index.html

```html
<!DOCTYPE html>
<html>
<head>
    <!--...-->
    <src="https://cdn.jsdelivr.net/gh/Nikoro/system_date_time_format@main/web/system_date_time_format.min.js"></script>
</head>
<body>
<!--...-->
</body>
</html>
```

### Testing

As the plugin class is not static, it is possible to mock and verify its behaviour when writing
tests as part of your application.  
Check the source code
of [example_with_tests](https://github.com/Nikoro/system_date_time_format/tree/main/example_with_tests)
which is a modification of
basic [example](https://github.com/Nikoro/system_date_time_format/tree/main/example)  
with mocks thanks to [mocktail](https://pub.dev/packages/mocktail).