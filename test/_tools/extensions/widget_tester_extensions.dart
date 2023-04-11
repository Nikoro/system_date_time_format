part of 'extensions.dart';

extension WidgetTesterExtensions on WidgetTester {
  Future<BuildContext> createContext() async {
    await pumpWidget(Container());
    return element(find.byType(Container));
  }
}
