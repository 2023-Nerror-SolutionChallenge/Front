import 'package:flutter/material.dart';
import 'package:marbon/color.dart';
import 'package:marbon/size.dart';
import 'package:marbon/widgets/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              child: ListView(
                children: [
                  const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, color: dark_green_color),
                  ),
                  const SizedBox(
                    height: title_input_gap,
                  ),
                  LoginForm(),
                  const SizedBox(
                    height: 180,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account?",
                        style: TextStyle(
                          fontSize: 18,
                          color: dark_green_color,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: transparent_color,
                        ),
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                            fontSize: 18,
                            color: yellow_green_color,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/register");
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
