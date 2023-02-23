import 'package:flutter/material.dart';
import 'package:marbon/color.dart';
import 'package:marbon/size.dart';

import 'input_field.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginForm({super.key}); // 1. 글로벌 key
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const InputField("Email", "email"),
          const SizedBox(height: input_input_gap),
          const InputField("Password", "pw"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: transparent_color,
                  foregroundColor: dark_green_color,
                ),
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "/forget_pw",
                  );
                },
              ),
              const SizedBox(
                width: 30,
              )
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: button_width,
            height: button_height,
            child: TextButton(
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                // 3. 유효성 검사
                if (_formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, "/smart_scan");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
