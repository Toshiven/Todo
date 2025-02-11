import 'package:flutter/material.dart';

class LastNameTextField extends StatelessWidget {
  const LastNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Last name',
        fillColor: Color(0xFFcdd6f4),
        hintStyle:
            TextStyle(color: Color(0xFFa6adc8), fontWeight: FontWeight.bold),
        border: OutlineInputBorder(),
      ),
    );
  }
}
