import 'package:flutter/material.dart';
import 'package:todo_app/views/todo.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Card(
              margin: EdgeInsets.all(20.0),
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        child: Text("Login"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TodoApp()),
                          );
                        },
                      ),
                    ],
                  )))),
      backgroundColor: const Color(0xFF1e1e2e),
    );
  }
}
