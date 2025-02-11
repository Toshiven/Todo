import 'package:flutter/material.dart';
import 'package:todo_app/widgets/email_text_field.dart';
import 'package:todo_app/widgets/login_button.dart';
import 'package:todo_app/widgets/password_text_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1e1e2e),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_box, size: 50, color: const Color(0xFFcdd6f4)),
              Text(
                "Login to the App!",
                style: TextStyle(color: const Color(0xFFcdd6f4)),
              ),
              SizedBox(height: 20),
              Card(
                color: Color(0xFFcdd6f4),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: 350,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        EmailTextField(),
                        SizedBox(height: 15),
                        PasswordInput(),
                        SizedBox(height: 20),
                        LoginButton(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "New to the app? Sign up",
                style: TextStyle(color: const Color(0xFFcdd6f4)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
