part of 'widgets.dart';

class BoldText extends StatelessWidget {
  const BoldText(this.data, {super.key});

  final String data;

  @override
  Widget build(BuildContext context) => Text(data, style: const TextStyle(fontWeight: FontWeight.bold));
}
