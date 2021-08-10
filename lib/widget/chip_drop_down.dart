import 'package:flutter/material.dart';

class ChipDropDown<Value> extends StatelessWidget {
  final ValueChanged<Value>? onSelect;
  final String chipText;
  final String title;
  final List<PopupMenuItem<Value>> values;

  const ChipDropDown({
    Key? key,
    required this.onSelect,
    required this.values,
    required this.chipText,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.white)),
        SizedBox(height: 4),
        PopupMenuButton<Value>(
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(chipText),
                Icon(Icons.keyboard_arrow_down)
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 4),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16)),
          ),
          itemBuilder: (context) {
            return values;
          },
          onSelected: (item) {
            onSelect?.call(item);
          },
        ),
      ],
    );
  }
}
