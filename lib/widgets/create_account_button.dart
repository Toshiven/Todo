import 'package:flutter/material.dart';
import 'package:todo_app/views/login.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFa6e3a1),
        foregroundColor: Color(0xFF1e1e2e),
        padding: EdgeInsets.symmetric(vertical: 14),
        textStyle: TextStyle(fontSize: 16),
      ),
      child: Text("Create account"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      },
    );
  }
}
