import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final Function() onPressed;

  const DeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed, child: const Text('Delete Items'));
  }
}
