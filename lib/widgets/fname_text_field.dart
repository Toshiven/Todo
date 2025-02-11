import 'package:flutter/material.dart';

class FirstNameTextField extends StatelessWidget {
  const FirstNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'First name',
        fillColor: const Color(0xFFbac2de),
        hintStyle: TextStyle(
            color: const Color(0xFF7f849c), fontWeight: FontWeight.bold),
        border: OutlineInputBorder(),
      ),
    );
  }
}
