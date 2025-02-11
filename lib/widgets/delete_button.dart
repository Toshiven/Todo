import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final Function() onPressed;

  const DeleteButton({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFf38ba8),
            foregroundColor: const Color(0xFF1e1e2e),
            shape: CircleBorder(),
            padding: EdgeInsets.all(20)),
        onPressed: onPressed,
        child: Icon(
          Icons.delete,
          color: const Color(0xFF1e1e2e),
        ));
  }
}
