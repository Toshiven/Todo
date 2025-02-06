import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final Function() onPressed;

  const DeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: EdgeInsets.only(
                top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        onPressed: onPressed,
        child: const Text('Delete Items'));
  }
}
