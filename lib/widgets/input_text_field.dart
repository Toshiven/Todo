import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;

  const InputTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.8),
          hintText: "Add Tasks",
          hintStyle:
              TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
        ));
  }
}
