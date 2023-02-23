import 'package:flutter/material.dart';
import 'package:marbon/color.dart';
import 'package:marbon/widgets/register_form.dart';

import '../size.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: circle_start,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: back_round_color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(circle_radius),
                  topRight: Radius.circular(circle_radius),
                ),
              ),
              child: ListView(children: [
                const Text(
                  "Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: dark_green_color,
                  ),
                ),
                const SizedBox(height: title_input_gap),
                RegisterForm(),
                const SizedBox(
                  height: 120,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 18, color: dark_green_color),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: transparent_color,
                      ),
                      child: const Text(
                        "Login Now",
                        style: TextStyle(
                          fontSize: 18,
                          color: yellow_green_color,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
