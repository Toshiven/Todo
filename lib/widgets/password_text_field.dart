import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Password',
        fillColor: const Color(0xFFbac2de),
        hintStyle: TextStyle(
            color: const Color(0xFF7f849c), fontWeight: FontWeight.bold),
        border: OutlineInputBorder(),
      ),
      obscureText: true,
    );
  }
}
