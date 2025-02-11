import 'package:flutter/material.dart';
import 'package:todo_app/views/todo.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFa6e3a1),
        foregroundColor: Color(0xFF1e1e2e),
        padding: EdgeInsets.symmetric(vertical: 14),
        textStyle: TextStyle(fontSize: 16),
      ),
      child: Text("Login"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TodoApp()),
        );
      },
    );
  }
}
