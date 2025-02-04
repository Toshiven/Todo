import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;

  const InputTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.6),
        hintText: "Tasks",
        hintStyle:
            TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
