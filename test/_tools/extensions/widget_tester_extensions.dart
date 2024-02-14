part of 'extensions.dart';

extension WidgetTesterExtensions on WidgetTester {
  Future<void> setupWidget(Widget widget) {
    return pumpWidget(MaterialApp(home: widget));
  }
}
