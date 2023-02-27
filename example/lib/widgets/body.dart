part of 'widgets.dart';

class Body extends StatelessWidget {
  const Body({this.children = const [], super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
