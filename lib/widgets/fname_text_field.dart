import 'package:flutter/material.dart';

class FirstNameTextField extends StatelessWidget {
  const FirstNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'First name',
        border: OutlineInputBorder(),
      ),
    );
  }
}
