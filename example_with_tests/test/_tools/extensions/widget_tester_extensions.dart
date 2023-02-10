part of 'extensions.dart';

extension WidgetTesterExtensions on WidgetTester {
  List<T> widgetListByType<T extends Widget>() => widgetList<T>(find.byType(T)).toList();
}
