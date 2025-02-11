import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Email',
        fillColor: const Color(0xFFcdd6f4),
        hintStyle: TextStyle(
            color: const Color(0xFFa6adc8), fontWeight: FontWeight.bold),
        border: OutlineInputBorder(),
      ),
    );
  }
}
