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
            activeColor: Color(0xFF89b4fa),
            checkColor: Color(0xFFbac2de),
            focusColor: Color(0xFFbac2de),
            side: BorderSide(color: Color(0xFFbac2de)),
          ),
          title: isEditing
              ? TextField(
                  controller: controller,
                  autofocus: true,
                  style: TextStyle(color: Color(0xFFbac2de)),
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Color(0xFFa6e3a1)),
                          onPressed: () {
                            widget.onUpdate(controller.text);
                            setState(() => isEditing = false);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: const Color(0xFFf38ba8),
                          ),
                          onPressed: () => setState(() => isEditing = false),
                        ),
                      ],
                    ),
                  ),
                )
              : Text(
                  widget.title,
                  style: TextStyle(color: Color(0xFFbac2de)),
                ),
          trailing: isEditing
              ? null
              : IconButton(
                  icon: Icon(Icons.edit, color: const Color(0xFFf9e2af)),
                  onPressed: () => setState(() => isEditing = true),
                ),
        ),
        Divider(),
      ],
    );
  }
}
