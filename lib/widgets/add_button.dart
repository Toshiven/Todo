import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF74c7ec),
          foregroundColor: Color(0xFF1e1e2e),
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
        ),
        onPressed: onPressed,
        child: Icon(
          Icons.add,
          color: const Color(0xFF1e1e2e),
        ));
  }
}
