import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  final bool value;
  final Function(bool value) onChange;
  final Function() delete;
  final String title;

  const CustomItem(
      {super.key,
      required this.value,
      required this.onChange,
      required this.delete,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          value: value,
          // title: Text(_items[index]),
          onChanged: (value) {
            if (value != null) {
              onChange(value);
            }
          }),
      title: Text(title),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: delete,
      ),
    );
  }
}
