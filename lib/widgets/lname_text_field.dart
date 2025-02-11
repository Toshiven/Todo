import 'package:flutter/material.dart';

class LastNameTextField extends StatelessWidget {
  const LastNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Last name',
        border: OutlineInputBorder(),
      ),
    );
  }
}
