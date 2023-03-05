part of 'widgets.dart';

class RowItem extends StatelessWidget {
  const RowItem({required this.title, required this.value, super.key});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BoldText(title),
          Text(value),
        ],
      ),
    );
  }
}
