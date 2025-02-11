import 'package:flutter/material.dart';
import 'package:todo_app/views/todo.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF1e1e2e),
        foregroundColor: const Color(0xFFcdd6f4),
        title: Text("LOGIN"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Login"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TodoApp()),
            );
          },
        ),
      ),
      backgroundColor: const Color(0xFF1e1e2e),
    );
  }
}
