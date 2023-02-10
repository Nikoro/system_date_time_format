part of 'widgets.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('System date time format example app'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
