import 'package:flutter/material.dart';

class CustomItem extends StatefulWidget {
  final bool value;
  final Function(bool) onChange;
  final String title;
  final Function(String) onUpdate;

  const CustomItem({
    super.key,
    required this.value,
    required this.onChange,
    required this.title,
    required this.onUpdate,
  });

  @override
  CustomItemState createState() => CustomItemState();
}

class CustomItemState extends State<CustomItem> {
  bool isEditing = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.title);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Checkbox(
            value: widget.value,
            onChanged: (value) => widget.onChange(value ?? false),
          ),
          title: isEditing
              ? TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            widget.onUpdate(controller.text);
                            setState(() => isEditing = false);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () => setState(() => isEditing = false),
                        ),
                      ],
                    ),
                  ),
                )
              : Text(widget.title),
          trailing: isEditing
              ? null
              : IconButton(
                  icon: Icon(Icons.edit, color: Colors.amberAccent),
                  onPressed: () => setState(() => isEditing = true),
                ),
        ),
        Divider(),
      ],
    );
  }
}
