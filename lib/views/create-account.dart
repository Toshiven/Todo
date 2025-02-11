import 'package:flutter/material.dart';
import 'package:todo_app/widgets/create_account_button.dart';
import 'package:todo_app/widgets/email_text_field.dart';
import 'package:todo_app/widgets/fname_text_field.dart';
import 'package:todo_app/widgets/lname_text_field.dart';
import 'package:todo_app/widgets/password_text_field.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF1e1e2e),
        foregroundColor: const Color(0xFFcdd6f4),
      ),
      backgroundColor: const Color(0xFF1e1e2e),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_box, size: 50, color: const Color(0xFFcdd6f4)),
              Text(
                "Register to the App!",
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
                        Text('Welcome to the create account page!'),
                        SizedBox(height: 15),
                        FirstNameTextField(),
                        SizedBox(height: 15),
                        LastNameTextField(),
                        SizedBox(height: 15),
                        EmailTextField(),
                        SizedBox(height: 15),
                        PasswordInput(),
                        SizedBox(height: 20),
                        CreateAccountButton(),
//TODO: Write Input Fields for creating account
//First Name, Last Name, Email, and Password
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
